part of '../index.dart';

class MonifyPaymentService {
  late Monnify? monnify;
  Future<List<String>> initiatePayment({
    required double amount,
    required String paymentMethod,
    required String listingId,
    required bool isContinuedInstallment,
  }) async {
    try {
      // Generate a unique transaction reference
      String reference = "txn_${DateTime.now().millisecondsSinceEpoch}";
      String userEmail = FirebaseAuth.instance.currentUser?.email ?? "";
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

      // Ensure Monnify is initialized before calling checkout
      final monnify = await Monnify.initialize(
        applicationMode: ApplicationMode.TEST,
        apiKey: "MK_TEST_Q6YXLJDRWK",
        contractCode: "5816429673",
      );
      //  apiKey: "MK_TEST_Q6BGTJV64R",
      //   contractCode: "6496718573",

      final transaction = TransactionDetails().copyWith(
          amount: amount,
          currencyCode: 'NGN',
          customerName: 'Customer Name',
          customerEmail: userEmail,
          paymentReference: reference,
          metaData: {
            "listingId": listingId, // Include listingId in metadata
            "paymentMethod": paymentMethod,
            "userId": FirebaseAuth.instance.currentUser?.uid ?? "",
            "isContinuedInstallment":
                isContinuedInstallment.toString(), // Store user ID for tracking
          }
          // paymentMethods: [PaymentMethod.CARD, PaymentMethod.ACCOUNT_TRANSFER, PaymentMethod.USSD],
          /*incomeSplitConfig: [SubAccountDetails("MFY_SUB_319452883968", 10.5, 500, true),
          SubAccountDetails("MFY_SUB_259811283666", 10.5, 1000, false)]*/
          );

      final response =
          await monnify?.initializePayment(transaction: transaction);

      if (response!.transactionStatus == 'PAID') {
        print(response.transactionStatus);
        return [response.paymentReference, response.transactionStatus];
      } else {
        Get.offAllNamed("/failed-payment");
        throw Exception("Payment failed: ${response.transactionStatus}");
      }
    } catch (e) {
      print("Monnify Payment Error: $e");
      Get.offAllNamed("/failed-payment");
      throw Exception("Error initiating payment");
    }
  }
}
