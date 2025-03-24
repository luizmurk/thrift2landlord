part of '../index.dart';

// class MonifyPaymentService {
//   Future<List<String>> initiatePayment({
//     required double amount,
//     required String paymentMethod,
//     required String listingId,
//     required bool isContinuedInstallment,
//   }) async {
//     try {
//       // Generate a unique transaction reference
//       String reference = "txn_${DateTime.now().millisecondsSinceEpoch}";
//       String userEmail = FirebaseAuth.instance.currentUser?.email ?? "";
//       String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

//       // Ensure Monnify is initialized before calling checkout
//       await MonnifyPaymentSdk.initialize(
//         apiKey: "MK_TEST_4XZQZQZQZQ",
//         contractCode: "1234567890",
//         staging: true,
//       );

//       // Call Monnify's checkout
//       final response = await MonnifyPaymentSdk.checkout(
//         amount: amount,
//         currencyCode: "NGN",
//         customerEmail: userEmail,
//         customerName: "User",
//         paymentReference: reference,
//         paymentMethods: [PaymentMethod.CARD, PaymentMethod.BANK_TRANSFER],
//       );

//       if (response.status == TransactionStatus.PAID) {
//         return ["Payment successful", response.transactionReference];
//       } else {
//         throw Exception("Payment failed: ${response.status}");
//       }
//     } catch (e) {
//       print("Monnify Payment Error: $e");
//       throw Exception("Error initiating payment");
//     }
//   }
// }
