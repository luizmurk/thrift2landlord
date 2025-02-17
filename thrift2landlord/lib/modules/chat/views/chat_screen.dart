part of '../index.dart';

class ChatScreen extends StatelessWidget {
  final ChatController _chatController = Get.put(ChatController());
  final TextEditingController searchController =
      TextEditingController(); // Add this

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? 'assets/images/logo_dark.jpeg'
              : 'assets/images/logo_light.jpeg',
          width: AppSizes.homeIcon,
          height: AppSizes.homeIcon,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Add your help and support action here
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add your notifications action here
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}
