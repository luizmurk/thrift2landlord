part of './index.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());
  final String title = Get.arguments[0];
  @override
  void initState() {
    super.initState();
    controller.title.value = title;
    controller.fetchMessages(title);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(
              "Chat",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          bottomNavigationBar:
              !controller.aiMode.value ? CustomBottomAppBar() : TagContainer(),
          body: Stack(
            children: [
              if (controller.isLoading.value)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                StreamBuilder<List<Message>>(
                  stream: controller.messagesStream(controller.title.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final messages = snapshot.data!;
                      return ListView.builder(
                        reverse: false,
                        controller: controller.scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final currentMessage = messages[index];
                          final previousMessage =
                              index > 0 ? messages[index - 1] : null;
                          final currentDate = currentMessage.date;
                          final previousDate = previousMessage?.date;
                          final isDifferentDate = currentDate != previousDate;

                          return Column(
                            children: [
                              if (isDifferentDate)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEFEFEF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Text(
                                      currentDate!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              MessageWidget(
                                message: currentMessage,
                                isAgent: !controller.aiMode.value,
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
            ],
          ),
        ));
  }

  // void makePhoneCall(String phoneNumber) async {
  //   String url = 'tel:$phoneNumber';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
