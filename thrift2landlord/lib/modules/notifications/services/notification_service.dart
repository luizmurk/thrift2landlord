part of '../index.dart';

class NotificationsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<NotificationModel>> fetchNotifications(String? userId) {
    return _db
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromFirestore(doc))
            .toList());
  }

  Future<void> markAsRead(String notificationId) async {
    await _db
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }
}
