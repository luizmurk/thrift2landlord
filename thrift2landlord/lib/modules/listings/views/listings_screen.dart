part of '../index.dart';

class ListingScreen extends StatelessWidget {
  final ListingsController listingsController = Get.find<ListingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Obx(() {
        if (listingsController.isLoading.value) {
          return ListView.builder(
            itemCount: 5, // Number of skeleton loaders
            itemBuilder: (context, index) => ListingsSkeletonLoader(),
          );
        }

        return ListView.builder(
          itemCount: listingsController.properties.length,
          itemBuilder: (context, index) {
            var property = listingsController.properties[index];
            return Center(child: Text("properties"));
          },
        );
      }),
    );
  }
}
