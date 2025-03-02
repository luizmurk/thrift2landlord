part of './index.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final ChatController controller = Get.put(ChatController());
  bool _isMenuVisible = false;
  late Timer _timer;
  int tileIndex = 0;
  final List<Tab> tabs = <Tab>[
    Tab(text: '      All      '),
    Tab(text: '     Unread     '),
    Tab(text: '      Archived     '),
  ];

  @override
  void initState() {
    super.initState();
    // Call the function initially when the widget is first initialized
    _fetchChatsPeriodically();
  }

  @override
  void dispose() {
    // Dispose the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  void _fetchChatsPeriodically() {
    // Call the function initially
    controller.fetchAllChats();

    // Set up a Timer to call the function every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Use setState to trigger a rebuild after fetching chats
      setState(() {
        controller.fetchAllChats();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        appBar: AppBar(
          title: Text(
            "Messages",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          onPressed: () {
            controller.createChat().then((value) {
              print(value);
              controller.aiMode.value = true;
              return Get.to(ChatScreen(),
                  arguments: [controller.title.value, null]);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 20, // Blur radius
                  offset: Offset(1, 3), // Offset in the x and y direction
                ),
              ],
            ),
            child: SvgPicture.asset(
              'assets/images/start_chat.svg',
            ),
          ),
        ),
        body: Obx(() => Stack(
              children: [
                AppTabView(
                  tabs: ['All', 'Unread', 'Archived'],
                  count: [
                    controller.allCount.value,
                    controller.unreadCount.value,
                    controller.archivedCount.value
                  ],
                  children: [
                    _buildMessageList('All', controller.allMessages),
                    _buildMessageList('Unread', controller.allMessages),
                    _buildMessageList('Archived', controller.allMessages),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  // Function to build message list for each tab
  Widget _buildMessageList(String tabTitle, List<AllMessage> chats) {
    List<AllMessage> messages = chats;

    // Filter messages based on tab title
    if (tabTitle == 'All') {
      messages = messages.where((message) => !message.isArchived).toList();
    } else if (tabTitle == 'Unread') {
      messages = messages.where((message) => !message.isRead).toList();
    } else if (tabTitle == 'Archived') {
      messages = messages.where((message) => message.isArchived).toList();
    }

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        String title = messages[index].title;
        int startIndex = title.lastIndexOf(' ') + 1;
        String phoneNumber = title.substring(startIndex);
        String textBeforeNumber = "Hello";
        String hoursSpent = "";
        if (controller.lastMessages.isNotEmpty) {
          textBeforeNumber = controller.lastMessages[index]['text'];

          hoursSpent =
              controller.calculateHours(controller.lastMessages[index]['date']);
        }

        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(top: 15, bottom: 15),
          color: messages[index].isRead == false
              ? AppColors.offWhite
              : AppColors.light,
          child: Stack(children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 25,
                backgroundImage: !messages[index].isAgent
                    ? const AssetImage("assets/images/logo.jpeg")
                        as ImageProvider
                    : NetworkImage(messages[index].image),
              ),
              title: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: messages[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium // Apply the fontFamily to the text before the number
                        ),
                    TextSpan(
                        text: "\n${textBeforeNumber}",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium // Apply the fontFamily to the text before the number
                        ),
                    TextSpan(text: "\n"),
                    TextSpan(
                      text: "\n${phoneNumber}",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium, // Apply bold style to the phone number
                    ),
                  ],
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hoursSpent == '12 h' ? '0 h' : hoursSpent,
                    style: TextStyle(fontFamily: "K2D"),
                  ),
                  Container(
                    height: 20,
                    child: IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        setState(() {
                          tileIndex = index;
                          _isMenuVisible = !_isMenuVisible;
                        });
                      },
                    ),
                  ),
                ],
              ),
              onTap: () {
                controller.aiMode.value = !messages[index].isAgent;
                controller.markMessageAsRead(messages[index].title);
                Get.to(ChatScreen(), arguments: [
                  messages[index].title,
                ]);
              },
            ),
            if (_isMenuVisible && tileIndex == index)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  margin: EdgeInsets.only(left: 70),
                  width: 250,
                  color: AppColors.light,
                  child: Column(
                    children: [
                      messages[index].isRead
                          ? ListTile(
                              leading: Icon(Icons.macro_off),
                              title: Text('Mark as UnRead'),
                              onTap: () {
                                controller
                                    .markMessageAsUnRead(messages[index].title)
                                    .then((value) {
                                  _isMenuVisible = false;
                                  controller.fetchAllChats().then((value) {
                                    setState(() {});
                                  });
                                });
                              },
                            )
                          : ListTile(
                              leading: Icon(Icons.macro_off),
                              title: Text('Mark as Read'),
                              onTap: () {
                                controller
                                    .markMessageAsRead(messages[index].title)
                                    .then((value) {
                                  _isMenuVisible = false;
                                  controller.fetchAllChats().then((value) {
                                    setState(() {});
                                  });
                                });
                              },
                            ),
                      messages[index].isArchived
                          ? ListTile(
                              leading: Icon(Icons.archive),
                              title: Text('UnArchive'),
                              onTap: () {
                                controller
                                    .markMessageAsUnArchived(
                                        messages[index].title)
                                    .then((value) {
                                  _isMenuVisible = false;
                                  controller.fetchAllChats().then((value) {
                                    setState(() {});
                                  });
                                });
                              },
                            )
                          : ListTile(
                              leading: Icon(Icons.archive),
                              title: Text('Archive'),
                              onTap: () {
                                controller
                                    .markMessageAsArchived(
                                        messages[index].title)
                                    .then((value) {
                                  _isMenuVisible = false;
                                  controller.fetchAllChats().then((value) {
                                    setState(() {});
                                  });
                                });
                              },
                            ),
                    ],
                  ),
                ),
              ),
          ]),
        );
      },
    );
  }
}

// Model class for message
