part of '../index.dart';

class PaymentCheckoutController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PaymentService _paymentService = PaymentService();

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
      List<String> checkoutUrl = await _paymentService.initiatePayment(
        amount: installmentPlan.amount,
        paymentMethod: paymentMethod.value,
        listingId: listingId,
      );

      // Step 1: Pre-update listing details before payment
      DocumentReference listingRef =
          _firestore.collection('listings').doc(listingId);
      Map<String, dynamic> updateData = {
        'paymentHistory': FieldValue.arrayUnion([
          PaymentModel(
            paymentId: checkoutUrl[1],
            amount: installmentPlan.amount,
            date: DateTime.now(),
            status: 'pending',
            completionStatus: '0%',
            paymentMethod: paymentMethod.value,
          ).toMap()
        ]),
      };

      await listingRef.update(updateData);

      // Redirect user to Paystack checkout
      if (await canLaunch(checkoutUrl[0])) {
        await launch(checkoutUrl[0]);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception("Could not launch payment URL");
      }

      // Step 3: Webhook in Firebase Functions handles payment confirmation

      isLoading.value = false;
    } catch (e) {
      paymentError.value = e.toString();
      print("Payment Error: $e");
      // Rollback in case of failure
      await _rollbackFailedContinuedPayment(listingId);
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
      List<String> checkoutUrl = await _paymentService.initiatePayment(
        amount: isInstallment.value
            ? (installmentPaymentPlan.value?.amount ?? 0.0)
            : amount.value,
        paymentMethod: paymentMethod.value,
        listingId: listingId.value,
      );

      // Step 1: Pre-update listing details before payment
      DocumentReference listingRef =
          _firestore.collection('listings').doc(listingId.value);
      Map<String, dynamic> updateData = {
        'buyerId': userId,
        'owner': userId,
        'paymentHistory': FieldValue.arrayUnion([
          PaymentModel(
            paymentId: checkoutUrl[1],
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

      // Redirect user to Paystack checkout
      if (await canLaunch(checkoutUrl[0])) {
        await launch(checkoutUrl[0]);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception("Could not launch payment URL");
      }

      // Step 3: Webhook in Firebase Functions handles payment confirmation
      // No need to update Firestore here; webhook will update status on success/failure
    } catch (e) {
      paymentError.value = e.toString();
      print("Payment Error: $e");
      // Rollback in case of failure
      await _rollbackFailedPayment(listingId.value);
    } finally {
      isProcessingPayment.value = false;
      isLoading.value = false;
    }
  }

  Future<void> _rollbackFailedPayment(String listingId) async {
    try {
      DocumentReference listingRef =
          _firestore.collection('listings').doc(listingId);
      DocumentSnapshot listingSnap = await listingRef.get();
      List<dynamic> paymentHistory = listingSnap.get('paymentHistory') ?? [];
      String? lastTransactionId =
          paymentHistory.isNotEmpty ? paymentHistory.last['paymentId'] : null;

      if (lastTransactionId != null) {
        await listingRef.update({
          'paymentHistory': FieldValue.arrayRemove([
            {'paymentId': lastTransactionId}
          ]),
          'buyerID': null,
          'ownerID': null,
          'installmentPaymentPlan': null,
          'installmentMonths': null,
        });
      }
    } catch (e) {
      print("Rollback Error: $e");
    }
  }

  Future<void> _rollbackFailedContinuedPayment(String listingId) async {
    try {
      DocumentReference listingRef =
          _firestore.collection('listings').doc(listingId);
      DocumentSnapshot listingSnap = await listingRef.get();
      List<dynamic> paymentHistory = listingSnap.get('paymentHistory') ?? [];
      String? lastTransactionId =
          paymentHistory.isNotEmpty ? paymentHistory.last['paymentId'] : null;

      if (lastTransactionId != null) {
        await listingRef.update({
          'paymentHistory': FieldValue.arrayRemove([
            {'paymentId': lastTransactionId}
          ]),
        });
      }
    } catch (e) {
      print("Rollback Error: $e");
    }
  }
}
