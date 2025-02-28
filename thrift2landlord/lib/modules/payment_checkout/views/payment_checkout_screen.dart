part of '../index.dart';

class PaymentCheckoutScreen extends StatefulWidget {
  final ListingModel? listing;

  const PaymentCheckoutScreen({super.key, this.listing});

  @override
  State<PaymentCheckoutScreen> createState() => _PaymentCheckoutScreenState();
}

class _PaymentCheckoutScreenState extends State<PaymentCheckoutScreen> {
  final PaymentCheckoutController _controller =
      Get.put(PaymentCheckoutController());

  late ListingModel listing;
  bool _showSecondaryButton = false;
  bool _showBankTransferWidget = false;

  @override
  void initState() {
    super.initState();
    listing = Get.arguments as ListingModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                listing.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: AppSizes.secondaryGapHeight),
              _showBankTransferWidget
                  ? _BankTransferWidget()
                  : _PaymentOptionsWidget(
                      amount: (listing.price).toString(),
                      onFormValidated: () {
                        setState(() {
                          _showSecondaryButton = true;
                        });
                      },
                    ),
              SizedBox(height: AppSizes.primaryGapHeight),
              Divider(),
              SizedBox(height: AppSizes.primaryGapHeight),
              if (_showSecondaryButton)
                CustomSecondaryButton(
                  text: !_showBankTransferWidget
                      ? "Pay Via Bank Transfer"
                      : "Try PayStack",
                  onPressed: () {
                    setState(() {
                      _showBankTransferWidget = !_showBankTransferWidget;
                    });
                  },
                ),
              SizedBox(height: AppSizes.primaryGapHeight),
              !_showBankTransferWidget
                  ? CustomPrimaryButton(
                      text: "Pay Using Paystack",
                      onPressed: () {
                        // Handle Paystack payment
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
