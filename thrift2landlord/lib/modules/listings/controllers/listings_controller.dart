part of '../index.dart';

class ListingsController extends GetxController {
  final ListingsService _service = ListingsService();
  var categories = <CategoryModel>[].obs;
  var realtors = <UserModel>[].obs;
  var listings = <ListingModel>[].obs;
  var listingsFromSearch = <ListingModel>[].obs;
  var yourListings = <ListingModel>[].obs;
  var listing = Rxn<ListingModel>();
  var listingOfTheDay = Rxn<ListingModel>();
  var isLoading = false.obs;
  var isLoadingListingsFromSearch = false.obs;
  var isLoadingYourListings = false.obs;
  var isLoadingCategories = false.obs;
  var isLoadingListings = false.obs;
  var isLoadingListingOfTheDay = true.obs;
  var isLoadingRealtors = false.obs;
  var hasError = false.obs;
  var hasErrorCategories = false.obs;
  var hasErrorListings = false.obs;
  var hasErrorListingsFromSearch = false.obs;
  var hasErrorLoadingYourListings = false.obs;
  var hasErrorListingOfTheDay = false.obs;
  var hasErrorRealtors = false.obs;
  var currentUser = Rxn<UserModel>();

  ListingsController({bool isMock = false}) {
    _service.isMock = isMock;
  }

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

  // Future<void> getYourListings() async {
  //   try {
  //     isLoadingYourListings(true);
  //     hasErrorLoadingYourListings(false);
  //     yourListings.value =
  //         await _service.fetchYourListings(currentUser.value!.id);
  //   } catch (e) {
  //     hasErrorLoadingYourListings(true);
  //   } finally {
  //     isLoadingYourListings(false);
  //   }
  // }

  Future<void> searchListings(
    String? field,
    String? query,
  ) async {
    try {
      isLoadingListingsFromSearch(true);
      hasErrorListingsFromSearch(false);
      listingsFromSearch.value = await _service.searchListings(
        field,
        query,
      );
    } catch (e) {
      hasErrorListingsFromSearch(true);
    } finally {
      isLoadingListingsFromSearch(false);
    }
  }

  void showListingsFromSearch(BuildContext context, String? categoryId,
      String? searchTerm, String? realtorId) {
    CustomBottomSheet.show(
        context: context,
        title: realtorId == null ? 'Listings' : 'Realtor Listings',
        child: CategoryListingsModal(
          categoryId: categoryId,
          searchTerm: searchTerm,
          realtorId: realtorId,
        ));
  }

  void showListing(BuildContext context, ListingModel listing) {
    Get.toNamed(AppRoutes.listing, arguments: listing);
  }

  Future<void> fetchListings() async {
    try {
      isLoadingListings(true);
      hasErrorListings(false);
      listings.value = await _service.fetchListings();
    } catch (e) {
      hasErrorListings(true);
    } finally {
      isLoadingListings(false);
    }
  }

  Future<void> fetchListing(String id) async {
    try {
      isLoading(true);
      hasError(false);
      listing.value = await _service.fetchListing(id);
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addMockListing() async {
    try {
      isLoading.value = true;
      await _service.addMockListingToFirebase();
      Get.snackbar('Success', 'Mock listing added to Firebase!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add mock listing: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
