part of './../../index.dart';

class Agent {
  final String id;
  final String name;
  final String email;
  final String profilePictureUrl;
  final bool isAvailable;

  Agent({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
    required this.isAvailable,
  });

  factory Agent.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Agent(
      id: snapshot.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      profilePictureUrl: data['profilePictureUrl'] ?? '',
      isAvailable: data['isAvailable'] ?? false,
    );
  }
}

class Message {
  final bool? isRead;
  final bool isBot;
  final String text;
  final String sender;
  final String? time;
  final String? imageUrl;
  final String? date;

  Message(
      {this.isRead,
      required this.isBot,
      required this.text,
      required this.sender,
      this.time,
      this.imageUrl,
      this.date});

  factory Message.fromJson(Message json) {
    return Message(
      isRead: json.isRead,
      isBot: json.isBot,
      text: json.text,
      sender: json.sender,
      time: json.time ?? '',
      imageUrl: json.imageUrl ?? null,
      date: json.date ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isRead': isRead,
      'isBot': isBot,
      'text': text,
      'sender': sender,
      'time': time,
      'imageUrl': imageUrl,
      'date': date
    };
  }
}

class AllMessage {
  final String id;
  final String title;
  final bool isRead;
  final bool isArchived;
  final bool isAgent;
  final String name;
  final String image;
  final dynamic transaction;
  final List<Message>? messages;

  AllMessage(
      {required this.id,
      required this.title,
      required this.isRead,
      required this.isArchived,
      required this.isAgent,
      required this.name,
      required this.image,
      this.transaction,
      this.messages});

  String getCurrentDate() {
    // Get the current date and time
    final now = DateTime.now();

    // Format the date as 'MMM dd, yyyy' (e.g., 'Feb 24, 2024')
    final formatter = DateFormat('MMM dd, yyyy');

    // Return the formatted date as a string
    return formatter.format(now);
  }

  Map<String, dynamic> toJson() {
    final message = Message(
        isRead: true,
        isBot: true,
        sender: 'them',
        text: "Hey, How can i help you?",
        time: "",
        imageUrl: null,
        date: getCurrentDate());
    return {
      'id': id,
      'title': title,
      'isRead': isRead,
      'isArchived': isArchived,
      'isAgent': isAgent,
      'name': 'Iyawali Bot',
      'image': 'Iyawali Bot',
      'transaction': transaction,
      'messages': [message.toJson()],
    };
  }
}

List<String> replies = [
  "To become an agent, you need to fill out the application form on our website.",
  "Becoming an agent is easy! Just contact our support team for more information.",
  "Being an agent is a great opportunity! Visit our office for enrollment details.",
  "You can start your journey as an agent by attending our training sessions.",
  "Becoming an agent requires dedication and commitment. Contact us to learn more.",
  "To be an agent, you must have excellent communication skills and a passion for customer service.",
  "Our agency offers flexible working hours for agents. Join us now!",
  "We provide extensive training programs for aspiring agents. Enroll today!",
  "To join our team as an agent, you need to pass our screening process.",
  "As an agent, you'll have the opportunity to earn competitive commissions.",
  "Being an agent allows you to work from home and manage your own schedule.",
  "Joining our agency as an agent opens up various opportunities for career growth.",
  "To become an agent, you'll need to undergo background checks and interviews.",
  "Our agency values diversity and welcomes agents from all backgrounds.",
  "As an agent, you'll receive ongoing support and mentorship from our team.",
  "To become an agent, you should have a strong understanding of our products and services.",
  "Becoming an agent is a rewarding experience that offers financial independence.",
  "Joining our agency as an agent gives you access to exclusive perks and benefits.",
  "To become an agent, you'll need to attend orientation sessions and complete training modules.",
  "We provide our agents with cutting-edge technology tools to streamline their work.",
  "As an agent, you'll represent our brand and uphold our values in all interactions.",
  "Joining our team as an agent opens up opportunities for networking and collaboration.",
  "To be an agent, you should be proactive and able to adapt to changing situations.",
  "Our agency fosters a supportive environment where agents can thrive and succeed.",
  "As an agent, you'll have the chance to make a positive impact on people's lives.",
  "Joining our agency as an agent requires a passion for helping others.",
  "To become an agent, you'll need to demonstrate integrity and professionalism.",
  "Becoming an agent is the first step towards building a successful career in sales.",
  "As an agent, you'll have access to our comprehensive training materials and resources.",
  "Joining our team as an agent allows you to be part of a dynamic and innovative company.",
  "To be an agent, you should have a customer-centric mindset and a can-do attitude.",
  "Our agency values teamwork and collaboration among our agents.",
  "As an agent, you'll have the opportunity to earn performance-based incentives.",
  "Joining our agency as an agent gives you the flexibility to work from anywhere.",
  "To become an agent, you'll need to undergo product knowledge training sessions.",
  "Becoming an agent is a great way to gain sales experience and enhance your skills.",
  "As an agent, you'll have the chance to build long-lasting relationships with clients.",
  "Joining our team as an agent opens up doors to endless possibilities.",
  "To be an agent, you should be proactive in seeking out new opportunities.",
  "Our agency offers continuous learning and development opportunities for agents.",
  "As an agent, you'll have access to our network of industry experts and professionals.",
  "Joining our agency as an agent allows you to be part of a supportive community.",
  "To become an agent, you'll need to complete our onboarding process.",
  "Becoming an agent requires a commitment to excellence and customer satisfaction.",
  "As an agent, you'll receive regular feedback and coaching to help you succeed.",
  "Joining our team as an agent gives you the chance to build your own business.",
  "To be an agent, you should have a passion for sales and a drive to succeed.",
  "Our agency offers competitive commission rates and bonuses for top-performing agents.",
  "As an agent, you'll have the opportunity to attend exclusive training events and seminars.",
  "Joining our agency as an agent opens up opportunities for personal and professional growth.",
  "To become an agent, you'll need to demonstrate your sales skills and abilities.",
  "Becoming an agent is a great way to build relationships and expand your network.",
  "As an agent, you'll have access to our marketing materials and promotional resources.",
  "Joining our team as an agent allows you to be part of a reputable and established company.",
  "To be an agent, you should be proactive in seeking out new leads and opportunities.",
  "Our agency provides ongoing support and guidance to help our agents succeed.",
  "As an agent, you'll have the flexibility to create your own schedule and work at your own pace.",
  "Joining our agency as an agent gives you the opportunity to make a difference in people's lives.",
  "To become an agent, you'll need to undergo a comprehensive training program.",
  "Becoming an agent requires dedication, hard work, and a positive attitude.",
  "As an agent, you'll have the chance to earn unlimited income potential.",
  "Joining our team as an agent opens up doors to exciting career opportunities.",
  "To be an agent, you should be passionate about helping others and making a difference.",
  "Our agency values integrity, honesty, and transparency in all our agents.",
  "As an agent, you'll receive ongoing support and resources to help you succeed in your role.",
  "Joining our agency as an agent allows you to be part of a diverse and inclusive team.",
];
