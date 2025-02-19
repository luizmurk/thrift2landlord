part of '../index.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ListingsController controller = Get.put(ListingsController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thrift to Landlord",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.file_copy_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.primaryPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.primaryGapHeight),
                Text('From Top Selling Location',
                    style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: AppSizes.primaryGapHeight),
                Obx(() {
                  if (controller.isLoadingListings.value) {
                    return ListingOfTheDaySkeletonLoader(); // Replace with skeleton loader
                  } else if (controller.hasErrorListings.value) {
                    return Text('Failed to load listing of the day');
                  } else if (controller.listings.isEmpty) {
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
                }),
                SizedBox(height: AppSizes.primaryGapHeight),
                Text('Promotional Offer (Sales)',
                    style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: AppSizes.primaryGapHeight),
                Obx(() {
                  if (controller.isLoadingListings.value) {
                    return ListingOfTheDaySkeletonLoader(); // Replace with skeleton loader
                  } else if (controller.hasErrorListings.value) {
                    return Text('Failed to load listing of the day');
                  } else if (controller.listings.isEmpty) {
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
                }),
              ],
            )),
      ),
    );
  }
}
