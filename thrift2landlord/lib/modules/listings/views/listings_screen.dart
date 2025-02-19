part of '../index.dart';

class ListingsScreen extends StatefulWidget {
  @override
  _ListingsScreenState createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  final ListingsController controller =
      Get.put<ListingsController>(ListingsController());
  final TextEditingController searchController = TextEditingController();

  String? selectedLocation;
  final List<String> locations = ["Gwagwalada", "Apo", "Lugbe"];

  @override
  void initState() {
    super.initState();
    controller.searchListings(null, null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.dark
          : AppColors.light,
      appBar: AppBar(
        title: Text(
          "Explore",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: AppSizes.primaryPadding),
            child: CustomDropdown(
              value: selectedLocation,
              items: locations,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                  controller.searchListings(null, null, null);
                });
              },
              labelText: "Select Location",
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.primaryPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSizes.primaryGapHeight),
            CustomSearchBar(
              controller: searchController,
              hintText: "Search properties...",
              onSubmitted: (query) {
                controller.searchListings(null, query, null);
              }, // Show filter button
            ),
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
