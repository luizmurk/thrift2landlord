part of '../index.dart';

class ListingsService extends AppService {
  bool isMock;
  final Random random = Random();
  final String collectionPath = "listings";
  ListingsService({this.isMock = false});

  Future<List<ListingModel>> searchListings(
      String? field, String? query) async {
    try {
      if (isMock) {
        // Fetch from mock data
        return await MockDataService.getListings();
      } else {
        QuerySnapshot response;

        if (field == null || query == null) {
          // Fetch all listings if no search filters are applied
          response = await firestore.collection(collectionPath).get();
        } else if (field == 'city') {
          // Search by state (Exact match)
          response = await firestore
              .collection(collectionPath)
              .where('city', isEqualTo: query)
              .get();
        } else if (field == 'tags') {
          // Search by tags (Array contains match)
          response = await firestore
              .collection(collectionPath)
              .where('tags', arrayContains: query)
              .get();
        } else {
          return []; // Invalid field
        }

        return response.docs
            .map((doc) => ListingModel.fromMap(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ListingModel>> fetchListings() async {
    if (isMock) {
      return await MockDataService.getListings();
    }
    try {
      final response = await firestore.collection('listings').get();
      return response.docs
          .map((doc) => ListingModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addMockListingToFirebase() async {
    try {
      List<ListingModel> mockedListings = await MockDataService.getListings();
      ListingModel randomListing =
          mockedListings[random.nextInt(mockedListings.length)];

      await addDocument("listings", randomListing.toMap());

      print('Mocked listing added successfully!');
    } catch (e) {
      throw 'Error adding mocked listing: $e';
    }
  }

  Future<ListingModel?> fetchListing(String id) async {
    if (isMock) {
      return await MockDataService.getListingById(id);
    }
    try {
      final doc = await firestore.collection('listings').doc(id).get();

      if (!doc.exists) return null; // Return null if the document doesn't exist

      return ListingModel.fromMap(doc.data()!, doc.id);
    } catch (e) {
      rethrow; // Rethrow the error for handling at the controller level
    }
  }
}
