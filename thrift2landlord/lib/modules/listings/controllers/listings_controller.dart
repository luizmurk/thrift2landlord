part of '../index.dart';

class ListingsController extends GetxController {
  final ListingsService _service = ListingsService();
  var categories = <CategoryModel>[].obs;
  var realtors = <UserModel>[].obs;
  var listings = <ListingModel>[].obs;
  var listingsFromSearch = <ListingModel>[].obs;
  var listing = Rxn<ListingModel>();
  var listingOfTheDay = Rxn<ListingModel>();
  var isLoading = true.obs;
  var isLoadingListingsFromSearch = true.obs;
  var isLoadingCategories = true.obs;
  var isLoadingListings = true.obs;
  var isLoadingListingOfTheDay = true.obs;
  var isLoadingRealtors = true.obs;
  var hasError = false.obs;
  var hasErrorCategories = false.obs;
  var hasErrorListings = false.obs;
  var hasErrorListingsFromSearch = false.obs;
  var hasErrorListingOfTheDay = false.obs;
  var hasErrorRealtors = false.obs;

  ListingsController({bool isMock = true}) {
    _service.isMock = isMock;
  }

  @override
  void onInit() {
    fetchCategories();
    fetchListings();
    getListingOfTheDay();
    fetchRealtors();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories(true);
      hasErrorCategories(false);
      categories.value = await _service.fetchCategories();
    } catch (e) {
      hasErrorCategories(true);
    } finally {
      isLoadingCategories(false);
    }
  }

  Future<void> getListingsByCategory(
      String? categoryId, String? query, String? realtorId) async {
    try {
      isLoadingListingsFromSearch(true);
      hasErrorListingsFromSearch(false);
      listingsFromSearch.value =
          await _service.searchListings(categoryId, query, realtorId);
    } catch (e) {
      isLoading(true);
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
    CustomBottomSheet.show(
        context: context,
        title: 'Listing',
        child: ListingDetailsScreen(listing: listing));
  }

  Future<void> getListingOfTheDay() async {
    try {
      isLoadingListingOfTheDay(true);
      hasErrorListingOfTheDay(false);
      listingOfTheDay.value = await _service.fetchListingOfTheDay();
    } catch (e) {
      hasErrorListingOfTheDay(true);
    } finally {
      isLoadingListingOfTheDay(false);
    }
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

  Future<void> fetchRealtors() async {
    try {
      isLoadingRealtors(true);
      hasErrorRealtors(false);
      realtors.value = await _service.fetchRealtors();
    } catch (e) {
      hasErrorRealtors(true);
    } finally {
      isLoadingRealtors(false);
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
}
