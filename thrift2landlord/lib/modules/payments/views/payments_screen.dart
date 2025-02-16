part of '../index.dart';

class PaymentsScreen extends StatelessWidget {
  final PaymentsController _paymentsController = Get.put(PaymentsController());
  final TextEditingController searchController =
      TextEditingController(); // Add this

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? 'assets/images/logo_dark.jpeg'
              : 'assets/images/logo_light.jpeg',
          width: AppSizes.homeIcon,
          height: AppSizes.homeIcon,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Add your help and support action here
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Payments"),
      ),
    );
  }
}
