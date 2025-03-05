part of '../index.dart';

class NotificationsController extends GetxController {
  final NotificationsService _notificationsService = NotificationsService();

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxInt unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    String? userId = getUserId(); // Replace with actual user ID retrieval logic
    _notificationsService.fetchNotifications(userId).listen((newNotifications) {
      notifications.value = newNotifications;
      unreadCount.value = newNotifications.where((n) => !n.isRead).length;
    });
  }

  void markAsRead(String notificationId) async {
    await _notificationsService.markAsRead(notificationId);
    notifications.firstWhere((n) => n.id == notificationId).isRead = true;
    unreadCount.value = notifications.where((n) => !n.isRead).length;
  }

  String? getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  /// 📢 **Method to Push Random Test Notifications**
  void pushTestNotification() {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String? userId = getUserId();
    if (userId == null) return; // No user logged in, don't push

    List<String> testMessages = [
      "🔥 New property alert near you!",
      "📢 Your listing got 5 new views!",
      "🏡 Price drop on your favorite property!",
      "📨 A landlord responded to your inquiry!",
      "🚀 Limited-time rental discount available!",
    ];

    Random random = Random();
    String randomMessage = testMessages[random.nextInt(testMessages.length)];

    // Create the notification model
    NotificationModel newNotification = NotificationModel(
      id: _firestore.collection('notifications').doc().id,
      userId: userId,
      title: "New Notification",
      message: randomMessage,
      timestamp: Timestamp.now().toDate(),
      isRead: false,
    );

    // Push to Firestore
    _firestore
        .collection('notifications')
        .doc(newNotification.id)
        .set(newNotification.toMap());
  }
}
