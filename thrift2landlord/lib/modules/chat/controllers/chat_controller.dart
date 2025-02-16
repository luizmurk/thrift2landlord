part of '../index.dart';

class ChatController extends GetxController {
  var properties = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProperties();
  }

  void loadProperties() async {
    isLoading.value = true;
    // properties.value = await ListingsService.fetchProperties();
    isLoading.value = false;
  }
}
