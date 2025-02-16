part of '../index.dart';

class CategoryListingsModal extends StatelessWidget {
  final String? categoryId;
  final String? searchTerm;
  final String? realtorId;
  final ListingsController controller = Get.find<ListingsController>();

  CategoryListingsModal(
      {Key? key, this.categoryId, this.searchTerm, this.realtorId})
      : super(key: key) {
    if (searchTerm != null) {
      controller.getListingsByCategory(null, searchTerm, null);
    } // call search controller not this
    if (categoryId != null) {
      controller.getListingsByCategory(categoryId!, null, null);
    }
    if (realtorId != null) {
      controller.getListingsByCategory(null, null, realtorId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingListingsFromSearch.value) {
        return ListingsSkeletonLoader(); // Show loading state
      }
      if (controller.hasErrorListingsFromSearch.value) {
        return Center(child: Text('Failed to fetch listings'));
      }
      if (controller.listingsFromSearch.isEmpty) {
        return Center(child: Text('No listings found'));
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
          itemCount: controller.listingsFromSearch.length,
          padding: EdgeInsets.symmetric(vertical: AppSizes.primaryGapHeight),
          itemBuilder: (context, index) {
            final listing = controller.listingsFromSearch[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: GestureDetector(
                onTap: () {
                  controller.showListing(context, listing);
                },
                child: PropertyListTile(
                  imageUrls: listing.imageUrls,
                  title: listing.title,
                  rating: listing.rating,
                  category: listing.categories.first.name,
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
