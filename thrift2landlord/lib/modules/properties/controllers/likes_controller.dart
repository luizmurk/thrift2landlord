part of '../index.dart';

class LikesController extends GetxController {
  final LikesService _likesService = LikesService();
  var likedProperties = <ListingModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (!Get.isRegistered<LikesController>()) {
      Get.put(LikesController());
    }
    fetchUserLikes();
  }

  Future<void> fetchUserLikes() async {
    isLoading.value = true;
    var likes = await _likesService.getUserLikedListings();
    likedProperties.assignAll(likes);
    isLoading.value = false;
  }

  Future<void> toggleLike(ListingModel listing) async {
    bool isLiked = likedProperties.any((p) => p.id == listing.id);

    if (isLiked) {
      likedProperties.removeWhere((p) => p.id == listing.id);
      await _likesService.removeLike(listing.id);
    } else {
      likedProperties.add(listing);
      await _likesService.addLike(listing);
    }
  }
}
