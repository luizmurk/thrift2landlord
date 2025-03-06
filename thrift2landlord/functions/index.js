const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const cors = require("cors");

admin.initializeApp();

const app = express();
app.use(cors({ origin: true }));
app.use(express.json());

// Default route to prevent "Cannot GET /" error
app.get("/", (req, res) => {
    res.send("Paystack Webhook is running.");
});

app.post("/paystack-webhook", async (req, res) => {
    console.log("🔵 Webhook received!");

    // Log full request body
    console.log("📥 Request Body:", JSON.stringify(req.body, null, 2));

    try {
        const event = req.body;

        if (event.event !== "charge.success") {
            console.log("⚠️ Not a charge.success event");
            return res.status(400).send("Not a successful charge event.");
        }

        const { reference, amount, metadata } = event.data;
        const listingId = metadata?.listingId; // Using optional chaining for safety

        console.log("✅ Charge successful");
        console.log(`🔹 Reference: ${reference}`);
        console.log(`🔹 Amount: ${amount}`);
        console.log(`🔹 Listing ID: ${listingId}`);

        if (!listingId || !reference) {
            console.log("🚨 Missing listingId or reference!");
            return res.status(400).send("Missing listingId or reference.");
        }

        // Fetch listing from Firestore
        const listingRef = admin.firestore().collection("listings").doc(listingId);
        const listingDoc = await listingRef.get();

        if (!listingDoc.exists) {
            console.log("🚨 Listing not found in Firestore!");
            return res.status(404).send("Listing not found.");
        }

        console.log("🟢 Listing found, updating payment history...");

        let listingData = listingDoc.data();
        let paymentHistory = listingData.paymentHistory || [];

        let paymentIndex = paymentHistory.findIndex(p => p.paymentId === reference);

        if (paymentIndex === -1) {
            console.log("🚨 Payment reference not found in history!");
            return res.status(400).send("Payment reference not found in history.");
        }

        // Update the payment entry
        paymentHistory[paymentIndex].status = "complete";
        paymentHistory[paymentIndex].completionStatus = "100%";
        paymentHistory[paymentIndex].date = new Date().toISOString();

        await listingRef.update({
            paymentHistory: paymentHistory,
            totalPaidAmount: admin.firestore.FieldValue.increment(amount / 100),
        });

       // Fetch the updated listing to check totalPaidAmount
        const updatedListingDoc = await listingRef.get();
        const updatedListingData = updatedListingDoc.data();

        if (updatedListingData.totalPaidAmount >= updatedListingData.price) {
            console.log("🎉 Listing fully paid! Marking as complete...");

            await listingRef.update({
                isFullyPaid: true,
            });
        }

        console.log("✅ Payment update process complete!");
        return res.status(200).send("Payment updated successfully.");
    } catch (error) {
        console.error("🚨 Error processing webhook:", error);
        return res.status(500).send("Internal Server Error.");
    }
});

// Expose the API
exports.api = functions.https.onRequest(app);
