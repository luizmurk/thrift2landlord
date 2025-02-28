part of '../index.dart';

class DocumentsPage extends StatelessWidget {
  final PropertiesController propertyController =
      Get.put(PropertiesController());

  DocumentsPage({super.key}) {
    propertyController.fetchProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Documents",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Obx(() {
        if (propertyController.isLoading.value) {
          return _buildSkeletonLoader();
        } else if (propertyController.hasError.value) {
          return Center(child: Text('Error loading listings'));
        } else if (propertyController.properties.isEmpty) {
          return Center(
              child: EmptyCMPState(
            title: '📜 No Documents Yet!',
            body:
                'You don’t have any property documents yet. Buy land first to receive your official digital property document after payment',
            buttonText: 'Create Listing',
            onButtonPressed: () {
              Get.toNamed(AppRoutes.listings);
            },
          ));
        } else {
          return Padding(
            padding: EdgeInsets.all(AppSizes.primaryPadding),
            child: ListView.builder(
              itemCount: propertyController.properties.length,
              itemBuilder: (context, index) {
                final ListingModel listing =
                    propertyController.properties[index];
                return _buildListingCard(context, listing);
              },
            ),
          );
        }
      }),
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              color: Colors.grey[300],
            ),
            title: Container(
              width: double.infinity,
              height: 20,
              color: Colors.grey[300],
            ),
            subtitle: Container(
              width: double.infinity,
              height: 20,
              color: Colors.grey[300],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListingCard(BuildContext context, ListingModel listing) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.secondaryPadding),
        child: ListTile(
          leading: ClipRRect(
            borderRadius:
                BorderRadius.circular(10.r), // Adjust radius as needed
            child: Image.network(
              listing.imageUrls.isNotEmpty ? listing.imageUrls.first : '',
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            '${listing.title}, ${listing.city}, ${listing.country}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          onTap: () {
            if (listing.documents.isNotEmpty) {
              _downloadDocument(listing.documents.first);
            } else {
              Get.snackbar('No Document', 'This listing has no documents.');
            }
          },
        ),
      ),
    );
  }

  void _downloadDocument(DocumentModel document) {
    // Implement the document download logic here
    // For example, you can use the url_launcher package to open the document URL
    // launch(document.url);
  }
}
