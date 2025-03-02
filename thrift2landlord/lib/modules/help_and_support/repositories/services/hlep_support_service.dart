part of './../../index.dart';

class HelpSupportService {
  final CollectionReference _messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  Stream<List<Message>> getMessages() {
    return _messagesCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Message(
                  isRead: doc['isRead'],
                  isBot: doc['isBot'],
                  text: doc['text'],
                  sender: doc['sender'],
                  time: doc['time'],
                  imageUrl: doc['imageUrl'] ?? null,
                  date: doc['date'] ?? 'Feb 24, 2024',
                ))
            .toList());
  }

  static Future<AllMessage> createMessage(
      String title, bool isRead, List<Message> messages, String userId) async {
    final CollectionReference allMessagesCollection =
        FirebaseFirestore.instance.collection('help_support_messages');
    final message = new AllMessage(
      id: userId,
      title: title,
      isRead: isRead,
      isArchived: false,
      isAgent: false,
      name: 'iyawali bot',
      image: 'iyawali bot',
    );
    try {
      await allMessagesCollection.add(message.toJson());
      return message;
    } catch (e) {
      throw ('Error creating message: $e');
    }
  }

  Future<void> sendMessage(Message message) async {
    await _messagesCollection.add({
      'text': message.text,
      'senderId': message.sender,
      'time': message.time
    });
  }
}
