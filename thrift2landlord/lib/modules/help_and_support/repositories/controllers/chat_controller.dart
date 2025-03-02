part of './../../index.dart';

class ChatController extends GetxController {
  RxString phoneNumber = ''.obs;
  RxString phoneCountry = ''.obs;
  RxString phoneFlag = ''.obs;
  final dragPosition = Rx<Offset>(Offset(16, 8)); // Default starting position
  var currentUser = Rxn<UserModel>();
  RxInt unreadCount = 0.obs;
  RxInt allCount = 0.obs;
  RxInt archivedCount = 0.obs;
  RxBool isLoading = false.obs;
  RxBool aiMode = true.obs;
  RxString title = "".obs;
  RxString newChatTitle = "".obs;
  RxList<Message> messages = <Message>[].obs;
  TextEditingController textEditingController = TextEditingController();
  RxList<AllMessage> allMessages = <AllMessage>[].obs;
  RxList<Agent> availableAgents = RxList<Agent>();
  late ScrollController scrollController;
  final lastMessages = [].obs;

  @override
  void onInit() {
    super.onInit();
    checkLoggedInUser();
    availableAgentsStream().listen((agents) {
      availableAgents.assignAll(agents);
    });
    fetchAllChats();
    scrollController = ScrollController();
  }

  Future<void> checkLoggedInUser() async {
    UserModel? storedUser = await SharedService.getUserFromStorage();
    if (storedUser != null) {
      currentUser.value = storedUser; // Navigate to Home Screen
    }
  }

  Stream<List<Agent>> availableAgentsStream() {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return _firestore
        .collection('customer_care_personel')
        .where('isAvailable', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Agent.fromSnapshot(doc)).toList());
  }

  Agent? selectAgent() {
    if (availableAgents.isEmpty) {
      return null;
    }

    final selectedAgent = availableAgents[0];
    return selectedAgent;
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  returnUnreadCount() {
    List<AllMessage> chats = allMessages;
    List<AllMessage> messages =
        chats.where((message) => !message.isRead).toList();
    unreadCount.value = messages.length;
  }

  returnAllCount() {
    List<AllMessage> chats = allMessages;
    List<AllMessage> messages =
        chats.where((message) => !message.isArchived).toList();
    allCount.value = messages.length;
  }

  returnArchivedCount() {
    List<AllMessage> chats = allMessages;
    List<AllMessage> messages =
        chats.where((message) => message.isArchived).toList();
    archivedCount.value = messages.length;
  }

  String generateRandomId() {
    Random random = Random();
    String id = '';
    for (int i = 0; i < 10; i++) {
      id += random.nextInt(10).toString();
    }
    return id;
  }

  String getCurrentDate() {
    // Get the current date and time
    final now = DateTime.now();

    // Format the date as 'MMM dd, yyyy' (e.g., 'Feb 24, 2024')
    final formatter = DateFormat('MMM dd, yyyy');

    // Return the formatted date as a string
    return formatter.format(now);
  }

  String convertToValidFormat(String date) {
    final monthMap = {
      'Jan': '01',
      'Feb': '02',
      'Mar': '03',
      'Apr': '04',
      'May': '05',
      'Jun': '06',
      'Jul': '07',
      'Aug': '08',
      'Sep': '09',
      'Oct': '10',
      'Nov': '11',
      'Dec': '12',
    };

    final parts = date.split(' ');
    final year = parts[2];
    final month = monthMap[parts[0]];
    final day = parts[1].replaceAll(',', '');

    return '$year-$month-$day';
  }

  String calculateHours(String lastMessageDate) {
    final convertedDate = convertToValidFormat(lastMessageDate);
    final lastMessageDateTime = DateTime.parse(convertedDate);
    final difference = DateTime.now().difference(lastMessageDateTime);
    final hours = difference.inMilliseconds ~/ Duration.millisecondsPerHour;
    return '$hours h';
  }

  String getCurrentTime() {
    // Get the current time
    DateTime now = DateTime.now();

    // Format the time using DateFormat
    String formattedTime = DateFormat.jm().format(now);

    // Return the formatted time
    return formattedTime;
  }

  String getRandomReply(String question) {
    // Generate a random index
    Random random = Random();
    int index = random.nextInt(replies.length);

    // Return the randomly selected reply
    return replies[index];
  }

  Future<void> switchToAgent() async {
    try {
      await FirebaseFirestore.instance
          .collection('help_support_messages')
          .where('title', isEqualTo: title.value)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          /// Check for avail
          if (selectAgent()?.name == null) {
            await sendMessage(
                isAI: true,
                message:
                    "Hello! There are no available Agents right now, Please check back shortly",
                imageFile: File(""));
          } else {
            await doc.reference.update({
              'isAgent': true,
              'name': selectAgent()?.name,
              'image': selectAgent()?.profilePictureUrl
            });
            await sendMessage(
                isAI: true,
                message:
                    "Hello! I am ${selectAgent()?.name}, How May i help you?",
                imageFile: File(""),
                Imageurl: selectAgent()?.profilePictureUrl);
            aiMode.value = false;
          }
        });
      });
    } catch (e) {
      throw ('Error marking message as read: $e');
    }
  }

  Future<void> markMessageAsUnRead(String title) async {
    try {
      await FirebaseFirestore.instance
          .collection('help_support_messages')
          .where('title', isEqualTo: title)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          await doc.reference.update({'isRead': false});
        });
      });
    } catch (e) {
      throw ('Error marking message as read: $e');
    }
  }

  Future<void> markMessageAsRead(String title) async {
    try {
      await FirebaseFirestore.instance
          .collection('help_support_messages')
          .where('title', isEqualTo: title)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          await doc.reference.update({'isRead': true});
        });
      });
    } catch (e) {
      throw ('Error marking message as read: $e');
    }
  }

  Future<void> markMessageAsArchived(String title) async {
    try {
      await FirebaseFirestore.instance
          .collection('help_support_messages')
          .where('title', isEqualTo: title)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          await doc.reference.update({'isArchived': true});
        });
      });
    } catch (e) {
      throw ('Error marking message as read: $e');
    }
  }

  Future<void> markMessageAsUnArchived(String title) async {
    try {
      await FirebaseFirestore.instance
          .collection('help_support_messages')
          .where('title', isEqualTo: title)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          await doc.reference.update({'isArchived': false});
        });
      });
    } catch (e) {
      throw ('Error marking message as read: $e');
    }
  }

  // Method to listen for the number of unread messages for a user
  Stream<int> getUnreadMessageCount() {
    final userId = currentUser.value?.id;
    return FirebaseFirestore.instance
        .collection('help_support_messages')
        .where('id', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      // Upload image to Firebase Storage
      final storageRef = firebase_storage.FirebaseStorage.instance.ref();
      final imageRef =
          storageRef.child('images/${DateTime.now().millisecondsSinceEpoch}');
      await imageRef.putFile(imageFile);

      // Get the download URL of the uploaded image
      final imageUrl = await imageRef.getDownloadURL();

      return imageUrl;
    } catch (e) {
      throw ('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  Future<void> sendMessage(
      {required bool isAI,
      required String? message,
      required File imageFile,
      String? Imageurl = null,
      String? myMessage = null}) async {
    if (imageFile.path.isNotEmpty && imageFile.existsSync()) {
      String? url = await uploadImageToFirebaseStorage(imageFile);

      final Message chat = Message(
          isRead: false,
          isBot: false,
          sender: 'Me',
          text: textEditingController.text,
          time: getCurrentTime(),
          imageUrl: url,
          date: getCurrentDate());
      messages.add(chat);
    } else {
      // throw ('Image file path is either empty or does not exist.');
      // Handle the case where the file path is empty or the file does not exist
      final List<Message> chat = [];
      if (!isAI) {
        chat.add(Message(
            isRead: false,
            isBot: false,
            sender: 'Me',
            text: textEditingController.text,
            time: getCurrentTime(),
            imageUrl: null,
            date: getCurrentDate()));
      } else {
        if (Imageurl == null) {
          chat.addAll([
            Message(
                isRead: true,
                isBot: true,
                sender: 'Me',
                text: myMessage ?? "",
                time: getCurrentTime(),
                imageUrl: Imageurl,
                date: getCurrentDate()),
            Message(
                isRead: true,
                isBot: true,
                sender: 'them',
                text: message ?? "",
                time: getCurrentTime(),
                imageUrl: Imageurl,
                date: getCurrentDate())
          ]);
        } else {
          chat.add(Message(
              isRead: true,
              isBot: false,
              sender: 'them',
              text: message ?? "",
              time: getCurrentTime(),
              imageUrl: Imageurl,
              date: getCurrentDate()));
        }
      }
      messages.addAll(chat);
    }
    try {
      // Get a reference to the Firestore collection
      CollectionReference allMessagesCollection =
          FirebaseFirestore.instance.collection('help_support_messages');
      final userId = currentUser.value?.id;

      // Query for documents where both 'userID' and 'title' fields match the specified values
      QuerySnapshot querySnapshot = await allMessagesCollection
          .where('id', isEqualTo: userId)
          .where('title', isEqualTo: title.value)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document from the query result
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        // Update the 'messages' field with the new array
        await allMessagesCollection.doc(documentSnapshot.id).update(
            {'messages': messages.map((message) => message.toJson()).toList()});
      } else {
        // No document found with the specified userID and title
        throw ('No document found with userID: $userId and title: $title');
      }
      textEditingController.clear();
    } catch (e) {
      // Error handling
      throw ('Error updating messages in Firebase: $e');
    }
  }

  void assignMessages(List<Message> messages) {
    messages.clear(); // Clear previous messages
    messages.assignAll(messages);
  }

  Future<void> getLastMessages() async {
    CollectionReference allMessagesCollection =
        FirebaseFirestore.instance.collection('help_support_messages');
    final userId = currentUser.value?.id;
    lastMessages.clear();
    try {
      final querySnapshot =
          await allMessagesCollection.where('id', isEqualTo: userId).get();

      querySnapshot.docs.forEach((doc) {
        final lastMessage = {
          'text': doc['messages'].last['text'] as String,
          'date': doc['messages'].last['date'] as String,
        };
        lastMessages.add(lastMessage);
      });
    } catch (e) {
      throw ('Error fetching last messages: $e');
    }
  }

  Future<String> getLastMessage(String title) async {
    CollectionReference allMessagesCollection =
        FirebaseFirestore.instance.collection('help_support_messages');
    final userId = currentUser.value?.id;
    try {
      QuerySnapshot querySnapshot = await allMessagesCollection
          .where('id', isEqualTo: userId)
          .where('title', isEqualTo: title)
          .orderBy('timestamp',
              descending: true) // Order by timestamp in descending order
          .limit(1) // Limit to 1 document
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the last message from the query snapshot
        return querySnapshot.docs.first['text'];
      } else {
        return "error finsing message"; // Return null if no message found
      }
    } catch (e) {
      throw ('Error fetching last message: $e');
      return "error finsing message";
      ;
    }
  }

  Stream<List<Message>> messagesStream(String title) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final userId = currentUser.value?.id;
    return _firestore
        .collection('help_support_messages')
        .where('id', isEqualTo: userId)
        .where('title', isEqualTo: title)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final List<Message> messageList = (doc['messages'] as List<dynamic>)
                .map((message) => Message(
                      isRead: message['isRead'],
                      isBot: message['isBot'],
                      text: message['text'],
                      sender: message['sender'],
                      time: message['time'],
                      imageUrl: message['imageUrl'] ?? null,
                      date: message['date'],
                    ))
                .toList();
            scrollToBottom();
            messages.assignAll(messageList);
            return messages;
          })
          .expand((element) => element)
          .toList();
    });
  }

  void fetchMessages(String title) async {
    CollectionReference allMessagesCollection =
        FirebaseFirestore.instance.collection('help_support_messages');
    final userId = currentUser.value?.id;
    try {
      QuerySnapshot querySnapshot = await allMessagesCollection
          .where('id', isEqualTo: userId)
          .where('title', isEqualTo: title)
          .get();
      // Extract only the 'messages' field from the document
      List<Message> fetchedMessages = querySnapshot.docs
          .map((doc) => (doc['messages'] as List<dynamic>)
              .map((message) => Message(
                    isRead: message['isRead'],
                    isBot: message['isBot'],
                    text: message['text'],
                    sender: message['sender'],
                    time: message['time'],
                    imageUrl: message['imageUrl'] ?? null,
                    date: message['date'],
                  ))
              .toList())
          .expand((element) => element)
          .toList();

      messages.assignAll(fetchedMessages);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      throw ('Error fetching messages: $e');
    }
  }

  Future<void> fetchAllChats() async {
    CollectionReference allMessagesCollection =
        FirebaseFirestore.instance.collection('help_support_messages');
    final userId = currentUser.value?.id;
    try {
      QuerySnapshot querySnapshot =
          await allMessagesCollection.where('id', isEqualTo: userId).get();
      List<AllMessage> allChats = querySnapshot.docs
          .map((doc) => AllMessage(
              id: doc['id'],
              title: doc['title'],
              isRead: doc['isRead'],
              isArchived: doc['isArchived'],
              isAgent: doc['isAgent'],
              name: doc['name'],
              image: doc['image'],
              transaction: doc['transaction']))
          .toList();
      await getLastMessages();
      allMessages.assignAll(allChats);
      returnAllCount();
      returnUnreadCount();
      returnArchivedCount();
    } catch (e) {
      isLoading.value = false;
      throw ('Error fetching messages: $e');
    }
  }

  Future<bool> createChat() async {
    try {
      title.value = 'Chat Conversation ${generateRandomId()}';
      final AllMessage chat = await HelpSupportService.createMessage(
          title.value, false, [], currentUser.value!.id);
      lastMessages.add({
        'text': "Hey, How can i help you?",
        'date': getCurrentDate(),
      });
      allMessages.add(chat);
      return true;
    } catch (e) {
      print('Error creating messages: $e');
      return false;
    }
  }
}
