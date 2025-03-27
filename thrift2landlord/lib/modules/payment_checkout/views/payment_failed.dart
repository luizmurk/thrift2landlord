part of '../index.dart';

class PaymentFailedPage extends StatelessWidget {
  const PaymentFailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Failed Payment",
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
              "Your payment has failed for some issue, Please Check you account and try again...",
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
