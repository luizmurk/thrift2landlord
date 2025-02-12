import 'app_services.dart';

class ListingsService extends AppService {
  final String collectionPath = "listings";

  /// Fetch all listings
  Future<List<Map<String, dynamic>>> getAllListings() async {
    return await fetchCollection(collectionPath);
  }

  /// Add a new property listing
  Future<void> addListing(Map<String, dynamic> listingData) async {
    await addDocument(collectionPath, listingData);
  }

  /// Update a listing
  Future<void> updateListing(
      String listingId, Map<String, dynamic> data) async {
    await updateDocument(collectionPath, listingId, data);
  }

  /// Delete a listing
  Future<void> deleteListing(String listingId) async {
    await deleteDocument(collectionPath, listingId);
  }

  /// Upload listing images
  // Future<String> uploadListingImage(String fileName, List<int> fileBytes) async {
  //   return await uploadImage("listing_images", fileName, fileBytes);
  // }
}
