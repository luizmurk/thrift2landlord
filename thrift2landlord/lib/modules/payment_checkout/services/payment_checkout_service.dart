part of '../index.dart';

class PaymentService {
  final String paystackSecretKey =
      "sk_test_fb515d0b1cdfb8a1348e0a73b285b4fee3722ad1";
  final String paystackBaseUrl =
      "https://api.paystack.co/transaction/initialize";

  Future<List<String>> initiatePayment({
    required double amount,
    required String paymentMethod,
    required String listingId,
  }) async {
    try {
      String reference = "txn_${DateTime.now().millisecondsSinceEpoch}";
      Map<String, String> headers = {
        "Authorization": "Bearer $paystackSecretKey",
        "Content-Type": "application/json",
      };

      Map<String, dynamic> body = {
        "amount": (amount * 100).toInt(), // Convert amount to kobo
        "email": FirebaseAuth.instance.currentUser?.email ?? "", // User's email
        "currency": "NGN",
        "reference": reference,
        "metadata": {
          "listingId": listingId, // Include listingId in metadata
          "paymentMethod": paymentMethod,
          "userId": FirebaseAuth
              .instance.currentUser?.uid, // Store user ID for tracking
        }
      };

      var response = await http.post(
        Uri.parse(paystackBaseUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return [
          responseBody["data"]["authorization_url"],
          responseBody["data"]['reference']
        ];
      } else {
        throw Exception("Failed to initiate payment");
      }
    } catch (e) {
      print("Paystack Payment Error: $e");
      throw Exception("Error initiating payment");
    }
  }
}
