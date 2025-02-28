part of '../index.dart';

class PropertiesController extends GetxController {
  final PropertyService _service;
  final bool isMock;

  PropertiesController({this.isMock = false})
      : _service = PropertyService(isMock: isMock);

  var isLoading = true.obs;
  var hasError = false.obs;
  var properties = <ListingModel>[].obs;
  var currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    checkLoggedInUser();
    super.onInit();
  }

  Future<void> checkLoggedInUser() async {
    UserModel? storedUser = await SharedService.getUserFromStorage();
    if (storedUser != null) {
      currentUser.value = storedUser; // Navigate to Home Screen
    }
  }

  void showListing(BuildContext context, ListingModel listing) {
    Get.toNamed(AppRoutes.listing, arguments: listing);
  }

  void fetchProperties() async {
    try {
      isLoading(true);
      hasError(false);
      properties.value = await _service.fetchProperties(currentUser.value!.id);
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}
