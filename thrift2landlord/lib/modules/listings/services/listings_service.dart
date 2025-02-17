part of '../index.dart';

class ListingsService extends AppService {
  bool isMock;

  ListingsService({this.isMock = false});

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      if (isMock) {
        // Fetch from mock data
        return await MockDataService.getCategories();
      } else {
        // Fetch from Firebase
        final response = await firestore.collection('categories').get();
        return response.docs
            .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
            .toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ListingModel>> fetchYourListings(String id) async {
    try {
      if (isMock) {
        // Fetch from mock data
        return await MockDataService.getYourListings();
      } else {
        // Fetch from Firebase
        final response = await firestore.collection('categories').get();
        return [];
        // return response.docs
        //     .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
        //     .toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ListingModel>> searchListings(
      String? id, String? query, String? realtorId) async {
    try {
      if (isMock) {
        // Fetch from mock data
        return await MockDataService.getListings();
      } else {
        // Fetch from Firebase
        final response = await firestore.collection('categories').get();
        return [];
        // return response.docs
        //     .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
        //     .toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> fetchRealtors() async {
    if (isMock) {
      return await MockDataService.getRealtors();
    }
    try {
      final response = await firestore.collection('Users').get();
      return response.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList();
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

  Future<ListingModel?> fetchListingOfTheDay() async {
    if (isMock) {
      return await MockDataService.getListingById("1");
    }
    try {
      final response = await firestore.collection('listings').get();
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<ListingModel?> fetchListing(String id) async {
    if (isMock) {
      return await MockDataService.getListingById(id);
    }
    try {
      final response = await firestore.collection('listings').get();
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ListingModel>> fetchListingsByCategory(String categoryId) async {
    try {
      final response = await firestore
          .collection('listings')
          .where('categoryIds', arrayContains: categoryId)
          .get();
      return response.docs
          .map((doc) => ListingModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
