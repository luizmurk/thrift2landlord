part of './index.dart';

class ListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingsController>(() => ListingsController());
  }
}
