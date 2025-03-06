part of '../index.dart';

class PaymentPendingPage extends StatelessWidget {
  const PaymentPendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pending Payment",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const CircularProgressIndicator(),
            // const SizedBox(height: 20),
            const Text(
              "Your payment is being processed...",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            CustomPrimaryButton(
              onPressed: () => Get.offAllNamed(AppRoutes.home),
              text: "Continue to Properties",
            ),
          ],
        ),
      ),
    );
  }
}
