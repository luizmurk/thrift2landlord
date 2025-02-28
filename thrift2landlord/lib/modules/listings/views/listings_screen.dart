part of '../index.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({super.key});

  @override
  _ListingsScreenState createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  final ListingsController controller =
      Get.put<ListingsController>(ListingsController());
  final TextEditingController searchController = TextEditingController();

  String? selectedLocation;
  final List<String> locations = ["Gwagwalada", "Apo", "Lugbe", "Wuse 3"];

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
                  controller.searchListings("city", value);
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
              hintText: "Search property tag...",
              onSubmitted: (query) {
                controller.searchListings(
                  "tags",
                  query,
                );
              }, // Show filter button
            ),
            // ElevatedButton(
            //   onPressed: controller.isLoading.value
            //       ? null
            //       : () => controller.addMockListing(),
            //   child: Obx(() => controller.isLoading.value
            //       ? CircularProgressIndicator()
            //       : Text('Add Mock Listing')),
            // ),
            SizedBox(height: AppSizes.primaryGapHeight),
            Obx(() {
              if (controller.isLoadingListingsFromSearch.value) {
                return ListingOfTheDaySkeletonLoader(); // Replace with skeleton loader
              } else if (controller.hasErrorListingsFromSearch.value) {
                return Text('Failed to load listing of the day');
              } else if (controller.listingsFromSearch.isEmpty) {
                return Center(
                    child: EmptyCMPState(
                  title: '🚫 No Results Found',
                  body:
                      'Explore available lands and make your first purchase today.',
                  buttonText: 'Find Properties Now',
                ));
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
