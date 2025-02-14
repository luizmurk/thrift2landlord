part of '../index.dart';

class ListingsScreen extends StatelessWidget {
  final ListingsController listingsController = Get.put(ListingsController());
  final TextEditingController searchController =
      TextEditingController(); // Add this

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Home",
        style: Theme.of(context).textTheme.headlineMedium,
      )),
      body: Column(
        children: [
          PropertyListTile(
            imageUrls: ['assets/images/logo_dark.jpeg'], // List of image URLs
            title: "property.title", // Property title
            rating: 4.3, // Double rating (e.g., 4.3)
            category: "Affordable", // e.g., "Affordable"
          ),
          CustomDivider(),
          PropertyListTile(
            imageUrls: ['assets/images/logo_light.jpeg'], // List of image URLs
            title: "property.title", // Property title
            rating: 4.3, // Double rating (e.g., 4.3)
            category: "Affordable", // e.g., "Affordable"
          ),
        ],
      ),
    );
  }
}
