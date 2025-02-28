part of '../index.dart';

class PropertyService extends AppService {
  bool isMock;

  PropertyService({this.isMock = false});

  Future<List<ListingModel>> fetchProperties(String? id) async {
    try {
      if (isMock) {
        // Fetch from mock data
        return await MockDataService.getYourListings();
      } else {
        // Fetch listings where 'owner' field matches the given id
        final response = await firestore
            .collection('listings')
            .where('owner', isEqualTo: id)
            .get();

        return response.docs
            .map((doc) => ListingModel.fromMap(doc.data(), doc.id))
            .toList();
      }
    } catch (e) {
      rethrow;
    }
  }
}
