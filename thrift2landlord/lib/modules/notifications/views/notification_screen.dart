part of '../index.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationsController controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(
              child: EmptyCMPState(
            title: '📜 No Notifications Yet!',
            body:
                'You don’t have any property documents yet. Buy land first to receive your official digital property document after payment',
            buttonText: 'Create Listing',
            onButtonPressed: () {
              Get.toNamed(AppRoutes.listings);
            },
          ));
        }
        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            NotificationModel notification = controller.notifications[index];
            return ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.message),
              trailing: notification.isRead
                  ? null
                  : Icon(Icons.circle, color: Colors.red, size: 10),
              onTap: () => controller.markAsRead(notification.id),
            );
          },
        );
      }),
    );
  }
}
