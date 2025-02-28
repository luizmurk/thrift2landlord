part of '../index.dart';

class NotificationService extends AppService {
  bool isMock;

  NotificationService({this.isMock = false});

  Future<List<NotificationModel>> fetchNotifications(String id) async {
    try {
      if (isMock) {
        // Fetch from mock data
        return await MockDataService.fetchNotifications();
      } else {
        // Fetch from Firebase
        final response = await firestore.collection('notifications').get();
        return response.docs
            .map((doc) => NotificationModel.fromJson(doc.data()))
            .toList();
      }
    } catch (e) {
      rethrow;
    }
  }
}
