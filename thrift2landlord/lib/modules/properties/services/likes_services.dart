part of '../index.dart';

class LikesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<List<ListingModel>> getUserLikedListings() async {
    try {
      var snapshot =
          await _firestore.collection("user_likes").doc(userId).get();
      if (!snapshot.exists) return [];

      List<dynamic> likedListings = snapshot.data()?["likedListings"] ?? [];
      List<ListingModel> listings = [];

      for (var listingId in likedListings) {
        var doc = await _firestore.collection("listings").doc(listingId).get();
        if (doc.exists) {
          listings.add(ListingModel.fromMap(doc.data()!, doc.id));
        }
      }
      return listings;
    } catch (e) {
      print("Error fetching likes: $e");
      return [];
    }
  }

  Future<void> addLike(ListingModel listing) async {
    var userLikesRef = _firestore.collection("user_likes").doc(userId);
    await userLikesRef.set({
      "likedListings": FieldValue.arrayUnion([listing.id])
    }, SetOptions(merge: true));
  }

  Future<void> removeLike(String listingId) async {
    var userLikesRef = _firestore.collection("user_likes").doc(userId);
    await userLikesRef.set({
      "likedListings": FieldValue.arrayRemove([listingId])
    }, SetOptions(merge: true));
  }
}
