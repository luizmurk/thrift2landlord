part of '../index.dart';

class MockDataService {
  static Future<List<NotificationModel>> fetchNotifications() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      NotificationModel(
        id: '1',
        title: 'Payment Received',
        message: 'Your payment for land installment has been received.',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
      ),
      NotificationModel(
        id: '2',
        title: 'New Listing Available',
        message: 'A new land listing has been added in your area.',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
      ),
    ];
  }
}
