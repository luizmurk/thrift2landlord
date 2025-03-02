part of './../../index.dart';

class TagContainer extends StatelessWidget {
  FAQController faqController = Get.put(FAQController());
  final ChatController controller = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      padding: EdgeInsets.all(8),
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          _buildTag(
            'How to be an Agent',
            context,
          ),
          _buildTag('Failed Transaction', context),
          _buildTag('How do I view my account statement', context),
          _buildTag('Update on Agent Registration', context),
          _buildTag('Other Requests', context),
          _buildTag('I want to talk with Customer Care', context),
        ],
      ),
    );
  }

  Widget _buildTag(String tagName, BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.lightGreen[100], // Light grey background for the tag
          borderRadius: BorderRadius.circular(
              20), // Completely circular border radius for the tag
        ),
        child: Text(
          tagName,
          style: TextStyle(
            color: Colors.black, // Text color for the tag
          ),
        ),
      ),
      onTap: () {
        if (tagName == 'I want to talk with Customer Care') {
          controller.sendMessage(
              isAI: true,
              message: 'Switching to an agent...',
              imageFile: File(""),
              myMessage: tagName);
          controller.switchToAgent();
        } else {
          controller.sendMessage(
              isAI: true,
              message: controller.getRandomReply(tagName),
              imageFile: File(""),
              myMessage: tagName);
        }
      },
    );
  }
}
