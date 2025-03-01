part of 'index.dart';

class KycBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KYCController>(() => KYCController());
  }
}
