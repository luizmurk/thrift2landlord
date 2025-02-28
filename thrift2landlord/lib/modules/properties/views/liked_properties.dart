part of '../index.dart';

class LikedProperties extends StatefulWidget {
  const LikedProperties({super.key});

  @override
  _LikedPropertiesState createState() => _LikedPropertiesState();
}

class _LikedPropertiesState extends State<LikedProperties> {
  final ListingsController controller =
      Get.put<ListingsController>(ListingsController());
  final TextEditingController searchController = TextEditingController();

  String? selectedLocation;
  final List<String> locations = ["Gwagwalada", "Apo", "Lugbe"];

  @override
  void initState() {
    super.initState();
    controller.searchListings(null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.dark
          : AppColors.light,
      appBar: AppBar(
        title: Text(
          "Liked Properties",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.primaryPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSizes.primaryGapHeight),
            Obx(() {
              if (controller.isLoadingListingsFromSearch.value) {
                return ListingOfTheDaySkeletonLoader(); // Replace with skeleton loader
              } else if (controller.hasErrorListingsFromSearch.value) {
                return Text('Failed to load listing of the day');
              } else if (controller.listingsFromSearch.isEmpty) {
                return Text('No listing of the day yet');
              }
              return SizedBox(
                height: 1000.h,
                width: 1000.w,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller.listingsFromSearch.length,
                  itemBuilder: (context, index) {
                    final listing = controller.listingsFromSearch[index];
                    return GestureDetector(
                      onTap: () {
                        controller.showListing(context, listing);
                      },
                      child: ListingsCard(
                        listing: listing,
                        isList: true,
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
