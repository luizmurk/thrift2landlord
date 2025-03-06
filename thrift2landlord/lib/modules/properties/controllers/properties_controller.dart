part of '../index.dart';

class PropertiesController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final PropertyService _service;
  final bool isMock;

  PropertiesController({this.isMock = false})
      : _service = PropertyService(isMock: isMock);

  var isLoading = true.obs;
  var hasError = false.obs;
  var properties = <ListingModel>[].obs;

  List<PaymentModel> getPayments() {
    List<PaymentModel> allPayments =
        properties.expand((property) => property.paymentHistory).toList();
    return allPayments;
  }

  void showListing(BuildContext context, ListingModel listing) {
    Get.toNamed(AppRoutes.listing, arguments: listing);
  }

  void fetchProperties() async {
    String? userId = _auth.currentUser?.uid;
    try {
      isLoading(true);
      hasError(false);
      properties.value = await _service.fetchProperties(userId);
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}
