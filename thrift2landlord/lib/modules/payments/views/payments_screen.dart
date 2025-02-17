part of '../index.dart';

class PaymentsScreen extends StatefulWidget {
  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final PaymentsController _controller = Get.put(PaymentsController());
  final ListingsController _listingController = Get.find<ListingsController>();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listingController.getYourListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add your notifications action here
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
                _listingController.showListingsFromSearch(
                    context, null, query, null);
              }, // Show filter button
            ),
            SizedBox(height: AppSizes.primaryGapHeight),
            Obx(() {
              if (_listingController.isLoadingYourListings.value) {
                return ListingOfTheDaySkeletonLoader(); // Replace with skeleton loader
              } else if (_listingController.hasErrorLoadingYourListings.value) {
                return Text('Failed to load your listings');
              } else if (_listingController.yourListings.isEmpty) {
                return Text('You have not bought any property yet');
              }
              return Container(
                height: 800.0, // Set a fixed height
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _listingController.yourListings.length,
                  itemBuilder: (context, index) {
                    final yourListing = _listingController.yourListings[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _controller.showListing(context, yourListing);
                          },
                          child: YourListing(
                            listing: yourListing,
                          ),
                        ),
                        Divider(), // Add a divider after each listing
                      ],
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
