part of '../index.dart';

class PaymentsController extends GetxController {
  var properties = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void showListing(BuildContext context, ListingModel listing) {
    CustomBottomSheet.show(
        context: context,
        title: 'Your Listing',
        child: ListingDetailsScreen(listing: listing));
  }

  void showPaymentHistory(
      BuildContext context,
      List<PaymentModel> paymentHistory,
      double completionPercentage,
      int monthsLeft,
      bool isComplete) {
    CustomBottomSheet.show(
        context: context,
        title: 'Payment History',
        child: PaymentHistoryWidget(
          paymentHistory: paymentHistory,
          completionPercentage: completionPercentage,
          monthsLeft: monthsLeft,
          isComplete: isComplete,
        ));
  }
}
