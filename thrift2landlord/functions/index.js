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

        // Extract important details
        const { reference, amount, metadata } = event.data;
        const listingId = metadata?.listingId;
        const isContinuedInstallment = metadata?.isContinuedInstallment || false; // Default to false

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

        let listingData = listingDoc.data();
        let paymentHistory = listingData.paymentHistory || [];

        // If it's not a successful payment, rollback and return
        if (event.event !== "charge.success") {
            console.log("⚠️ Not a charge.success event, rolling back...");

            await rollbackFailedPayment(listingRef, paymentHistory, isContinuedInstallment);
            return res.status(400).send("Not a successful charge event. Payment rolled back.");
        }

        console.log("✅ Charge successful");
        console.log(`🔹 Reference: ${reference}`);
        console.log(`🔹 Amount: ${amount}`);
        console.log(`🔹 Listing ID: ${listingId}`);

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
            totalPaidAmount: admin.firestore.FieldValue.increment(amount/100),
        });

        console.log("✅ Payment updated successfully!");
        return res.status(200).send("Payment updated successfully.");
    } catch (error) {
        console.error("🚨 Error processing webhook:", error);
        return res.status(500).send("Internal Server Error.");
    }
});

/**
 * Rollback failed payment for a listing.
 */
async function rollbackFailedPayment(listingRef, paymentHistory, isContinuedInstallment) {
    try {
        if (paymentHistory.length === 0) {
            console.log("⚠️ No payments to roll back.");
            return;
        }

        const lastTransactionId = paymentHistory[paymentHistory.length - 1].paymentId;

        if (!lastTransactionId) {
            console.log("⚠️ No valid last transaction found.");
            return;
        }

        console.log(`🔄 Rolling back last payment: ${lastTransactionId}`);

        let rollbackData = {
            paymentHistory: paymentHistory.filter(p => p.paymentId !== lastTransactionId),
        };

        if (!isContinuedInstallment) {
            // Reset additional fields for non-installment payments
            rollbackData = {
                ...rollbackData,
                buyerId: null,
                owner: null,
                installmentPaymentPlan: null,
                installmentMonths: null,
            };
        }

        await listingRef.update(rollbackData);
        console.log("✅ Rollback successful!");
    } catch (error) {
        console.error("🚨 Rollback Error:", error);
    }
}


// Expose the API
exports.api = functions.https.onRequest(app);
