part of '../index.dart';

class PaymentCheckoutController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PaymentService _paymentService = PaymentService();
  final MonifyPaymentService _monnifyPaymentService = MonifyPaymentService();

  var isProcessingPayment = false.obs;
  var selectedPaymentMethod = ''.obs;
  var paymentError = ''.obs;
  var listingId = ''.obs;
  var amount = 0.0.obs;
  var paymentMethod = "card".obs;
  var isInstallment = true.obs;
  var installmentMonths = 0.obs;
  var monthlyPaymentDate = Rxn<DateTime>();
  var installmentPaymentPlan = Rxn<InstallmentPlanModel>();
  var isLoading = false.obs;

  void updateListingDetails(String id, double listingAmount) {
    listingId.value = id;
    amount.value = listingAmount;
  }

  // void updateInstallmentPlan(int months) {
  //   installmentMonths.value = months;
  //   if (months > 0) {
  //     amount.value = (amount.value / months);
  //   }
  // }

  void updateInstallmentPlan(int months, DateTime paymentDate) {
    installmentMonths.value = months;
    monthlyPaymentDate.value = paymentDate;

    // Ensure valid months before setting the installment plan
    if (months > 0) {
      installmentPaymentPlan.value = InstallmentPlanModel(
        timeFrame: months,
        monthlyPaymentDate: paymentDate,
        amount: amount.value / months, // Divide by months
      );
    }
  }

  void setIsInstallment(bool value) {
    isInstallment.value = value;
  }

  Future<void> continueInstallmentPayment(String listingId) async {
    String? userId = _auth.currentUser?.uid;
    try {
      isLoading.value = true;

      // Fetch listing details
      final listingDoc =
          await _firestore.collection('listings').doc(listingId).get();
      if (!listingDoc.exists) {
        throw Exception("Listing not found");
      }

      final listingData = listingDoc.data()!;
      final installmentPlanData = listingData['installmentPlan'];
      if (installmentPlanData == null) {
        throw Exception("No installment plan found for this listing");
      }

      final InstallmentPlanModel installmentPlan =
          InstallmentPlanModel.fromMap(installmentPlanData);

      // Show confirmation dialog
      bool? confirm = await Get.defaultDialog(
        title: "Confirm Payment",
        middleText:
            "Are you sure you want to pay the next installment of ₦${installmentPlan.amount}? This payment is scheduled for ${DateFormat.yMMMd().format(installmentPlan.monthlyPaymentDate)}.",
        textConfirm: "Proceed with payment",
        textCancel: "Cancel",
        confirmTextColor: Colors.white,
        buttonColor: Colors.green,
        onConfirm: () => Get.back(result: true),
        onCancel: () => Get.back(result: false),
      );

      if (confirm == null || !confirm) {
        isLoading.value = false;
        return; // Exit if user cancels
      }

      // Step 2: Process payment through Paystack
      List<String> checkoutUrl = await _monnifyPaymentService.initiatePayment(
        amount: installmentPlan.amount,
        paymentMethod: paymentMethod.value,
        listingId: listingId,
        isContinuedInstallment: true,
      );

      // Step 1: Pre-update listing details before payment
      DocumentReference listingRef =
          _firestore.collection('listings').doc(listingId);
      Map<String, dynamic> updateData = {
        'paymentHistory': FieldValue.arrayUnion([
          PaymentModel(
            paymentId: checkoutUrl[0],
            amount: installmentPlan.amount,
            date: DateTime.now(),
            status: 'pending',
            completionStatus: '0%',
            paymentMethod: paymentMethod.value,
          ).toMap()
        ]),
      };

      await listingRef.update(updateData);

      await handleMonnifyWebhook(
          checkoutUrl[0], installmentPlan.amount, listingId, true);
      isLoading.value = false;

      Get.offAllNamed("/pending-payment");
    } catch (e) {
      paymentError.value = e.toString();
      print("Payment Error: $e");
    } finally {
      isProcessingPayment.value = false;
      isLoading.value = false;
    }
  }

  Future<void> processPayment() async {
    if (isProcessingPayment.value) return;
    if (isInstallment.value) {
      if (installmentPaymentPlan.value?.amount == null ||
          installmentPaymentPlan.value!.amount <= 0 ||
          amount.value <= 0) {
        Get.snackbar("Error", "Required fields are missing.");
        return;
      }
    }
    try {
      isLoading.value = true;
      isProcessingPayment.value = true;
      String? userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception("User not logged in");
      }

      // Step 2: Process payment through Paystack
      List<String> checkoutUrl = await _monnifyPaymentService.initiatePayment(
        amount: isInstallment.value
            ? (installmentPaymentPlan.value?.amount ?? 0.0)
            : amount.value,
        paymentMethod: paymentMethod.value,
        listingId: listingId.value,
        isContinuedInstallment: false,
      );

      // Step 1: Pre-update listing details before payment
      DocumentReference listingRef =
          _firestore.collection('listings').doc(listingId.value);
      Map<String, dynamic> updateData = {
        'buyerId': userId,
        'owner': userId,
        'paymentHistory': FieldValue.arrayUnion([
          PaymentModel(
            paymentId: checkoutUrl[0],
            amount: isInstallment.value
                ? (installmentPaymentPlan.value?.amount ?? 0.0)
                : amount.value,
            date: DateTime.now(),
            status: 'pending',
            completionStatus: '0%',
            paymentMethod: paymentMethod.value,
          ).toMap()
        ]),
      };

      if (isInstallment.value) {
        updateData.addAll({
          'installmentPlan': installmentPaymentPlan.value?.toMap(),
          'installmentMonths': installmentMonths.value,
        });
      }

      await listingRef.update(updateData);
      bool monnifyResponse = await handleMonnifyWebhook(
          checkoutUrl[0],
          isInstallment.value
              ? (installmentPaymentPlan.value?.amount ?? 0.0)
              : amount.value,
          listingId.value,
          false);
      isLoading.value = false;
      if (monnifyResponse) {
        Get.offAllNamed("/pending-payment");
      } else {
        Get.offAllNamed("/failed-payment");
      }
    } catch (e) {
      paymentError.value = e.toString();
      print("Payment Error: $e");
      Get.offAllNamed("/failed-payment");
    } finally {
      isProcessingPayment.value = false;
      isLoading.value = false;
    }
  }

  /// Handles the Monnify Webhook Callback
  Future<bool> handleMonnifyWebhook(String reference, double amount,
      String listingId, bool isContinuedInstallment) async {
    try {
      print("🔵 Webhook received!");

      if (listingId == null || reference == null) {
        print("🚨 Missing listingId or reference!");
        return false;
      }

      // Fetch listing from Firestore
      DocumentReference listingRef =
          _firestore.collection("listings").doc(listingId);
      DocumentSnapshot listingDoc = await listingRef.get();

      if (!listingDoc.exists) {
        print("🚨 Listing not found in Firestore!");
        return false;
      }

      Map<String, dynamic>? listingData =
          listingDoc.data() as Map<String, dynamic>?;
      List<dynamic> paymentHistory = listingData?['paymentHistory'] ?? [];

      print("✅ Transaction successful");
      print("🔹 Reference: $reference");
      print("🔹 Amount: $amount");
      print("🔹 Listing ID: $listingId");

      int paymentIndex =
          paymentHistory.indexWhere((p) => p['paymentId'] == reference);

      if (paymentIndex == -1) {
        print("🚨 Payment reference not found in history!");
        return false;
      }

      // Update the payment entry
      paymentHistory[paymentIndex]['status'] = "complete";
      paymentHistory[paymentIndex]['completionStatus'] = "100%";
      paymentHistory[paymentIndex]['date'] = DateTime.now().toIso8601String();

      await listingRef.update({
        'paymentHistory': paymentHistory,
        'totalPaidAmount': FieldValue.increment(amount),
      });

      print("🔄 Fetching updated listing to check totalPaidAmount...");
      DocumentSnapshot updatedListingDoc = await listingRef.get();
      Map<String, dynamic>? updatedListingData =
          updatedListingDoc.data() as Map<String, dynamic>?;

      if (updatedListingData != null &&
          (updatedListingData['totalPaidAmount'] ?? 0) >=
              (updatedListingData['price'] ?? double.infinity)) {
        print("🎉 Listing fully paid! Marking as complete...");

        await listingRef.update({
          'isFullyPaid': true,
        });
      }

      print("✅ Payment update process complete!");
      return true;
    } catch (error) {
      print("🚨 Error processing webhook: $error");
      return false;
    }
  }
}
