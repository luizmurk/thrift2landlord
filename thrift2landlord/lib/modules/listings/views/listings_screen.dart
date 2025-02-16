part of '../index.dart';

class ListingsScreen extends StatelessWidget {
  final ListingsController controller = Get.put(ListingsController());
  final TextEditingController searchController =
      TextEditingController(); // Add this

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.dark
          : AppColors.light,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.primaryPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.primaryGapHeight),
            CustomSearchBar(
              controller: searchController,
              hintText: "Search properties...",
              onSubmitted: (query) {
                controller.showListingsFromSearch(context, null, query, null);
              }, // Show filter button
            ),
            SizedBox(height: AppSizes.primaryGapHeight),
            Text('Categories',
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: AppSizes.primaryGapHeight),
            Obx(() {
              if (controller.isLoadingCategories.value) {
                return CategoriesSkeletonLoader(); // Replace with skeleton loader
              } else if (controller.hasErrorCategories.value) {
                return Text('Failed to load categories');
              } else if (controller.categories.isEmpty) {
                return Text('No categories found');
              }
              return SizedBox(
                height: AppSizes.categoriesSectionHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return GestureDetector(
                      onTap: () {
                        controller.showListingsFromSearch(
                            context, category.id, null, null);
                      },
                      child: CategoryCard(
                        imageUrl: category.imageUrl,
                        name: category.name,
                      ),
                    );
                  },
                ),
              );
            }),
            SizedBox(height: AppSizes.primaryGapHeight),
            Text('Top Realtors',
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: AppSizes.primaryGapHeight),
            Obx(() {
              if (controller.isLoadingRealtors.value) {
                return RealtorsSkeletonLoader(); // Custom skeleton loader
              } else if (controller.hasErrorRealtors.value) {
                return Text('Failed to load categories');
              } else if (controller.realtors.isEmpty) {
                return Text('No realtors found');
              }
              return SizedBox(
                height: AppSizes.realtorSectionHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.realtors.length,
                  itemBuilder: (context, index) {
                    final realtor = controller.realtors[index];
                    return GestureDetector(
                      onTap: () {
                        controller.showListingsFromSearch(
                            context, null, null, realtor.id);
                      },
                      child: RealtorCard(
                        profileImage: realtor.photoUrl ?? "",
                        name: realtor.name,
                        rating: (realtor.rating ?? 0).toDouble(),
                        propertiesListed: realtor.propertiesListed ?? 0,
                      ),
                    );
                  },
                ),
              );
            }),
            SizedBox(height: AppSizes.primaryGapHeight),
            Text('Listing of the Day',
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: AppSizes.primaryGapHeight),
            Obx(() {
              if (controller.isLoadingListingOfTheDay.value) {
                return ListingOfTheDaySkeletonLoader(); // Replace with skeleton loader
              } else if (controller.hasErrorListingOfTheDay.value) {
                return Text('Failed to load listing of the day');
              } else if (controller.listingOfTheDay.value == null) {
                return Text('No listing of the day yet');
              }
              return SizedBox(
                child: GestureDetector(
                  onTap: () {
                    controller.showListing(
                        context, controller.listingOfTheDay.value!);
                  },
                  child: ListingOfTheDayCard(
                    listing: controller.listingOfTheDay.value!,
                  ),
                ),
              );
            }),
            SizedBox(height: AppSizes.primaryGapHeight),
            Text('Near You', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: AppSizes.primaryGapHeight),
            Obx(() {
              if (controller.isLoadingListingOfTheDay.value) {
                return ListingOfTheDaySkeletonLoader(); // Replace with skeleton loader
              } else if (controller.hasErrorListingOfTheDay.value) {
                return Text('Failed to load listing of the day');
              } else if (controller.listingOfTheDay.value == null) {
                return Text('No listing of the day yet');
              }
              return SizedBox(
                height: AppSizes.listingCardHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.listings.length,
                  itemBuilder: (context, index) {
                    final listing = controller.listings[index];
                    return GestureDetector(
                      onTap: () {
                        controller.showListing(context, listing);
                      },
                      child: ListingsCard(
                        listing: listing,
                      ),
                    );
                  },
                ),
              );
              ;
            }),
          ],
        ),
      ),
    );
  }
}
