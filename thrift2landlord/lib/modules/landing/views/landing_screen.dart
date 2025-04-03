part of '../index.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ListingsController controller = Get.put(ListingsController());
  final NotificationsController notificationController =
      Get.put(NotificationsController());
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
            icon: SvgPicture.asset(
              'assets/icons/document.svg',
              height: 24, // Adjust size as needed
              color: AppColors.primary,
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.documents);
              // notificationController.pushTestNotification();
            },
          ),
          IconButton(
            icon: Stack(
              children: [
                SvgPicture.asset(
                  'assets/icons/notification.svg',
                  height: 24, // Adjust size as needed
                  color: AppColors.primary,
                ),
                Positioned(
                  right: 0,
                  child: Obx(() {
                    return notificationController.unreadCount.value > 0
                        ? Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: Text(
                              notificationController.unreadCount.value
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )
                        : SizedBox();
                  }),
                ),
              ],
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.notifications);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchListings();
        },
        child: SizedBox(
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
                  } else if (controller.topSellingListings.isEmpty) {
                    return Text('No Top Selling listings yet');
                  }
                  return SizedBox(
                    height: AppSizes.listingCardHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.topSellingListings.length,
                      itemBuilder: (context, index) {
                        final listing = controller.topSellingListings[index];
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
                  } else if (controller.promotionalListings.isEmpty) {
                    return Text('No Promo listings yet');
                  }
                  return SizedBox(
                    height: AppSizes.listingCardHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.promotionalListings.length,
                      itemBuilder: (context, index) {
                        final listing = controller.promotionalListings[index];
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
            ),
          ),
        ),
      ),
    );
  }
}
