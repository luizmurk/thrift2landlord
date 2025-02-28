part of '../index.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  final TextEditingController searchController = TextEditingController();

  NotificationsScreen({super.key});

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
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
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
              title: Text(
                notification.title,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              subtitle: Text(notification.body),
              trailing: Text(
                "4:20 AM",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            );
          },
        );
      }),
    );
  }
}
