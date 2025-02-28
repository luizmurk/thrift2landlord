part of '../index.dart';

class NotificationController extends GetxController {
  final NotificationService _service = NotificationService();
  var notifications = <NotificationModel>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  NotificationController({bool isMock = true}) {
    _service.isMock = isMock;
  }

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  void fetchNotifications() async {
    try {
      isLoading(true);
      hasError(false);
      notifications.value = await _service.fetchNotifications("");
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}
