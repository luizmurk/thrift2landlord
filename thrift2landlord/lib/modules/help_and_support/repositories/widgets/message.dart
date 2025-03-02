part of './../../index.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isAgent;

  const MessageWidget({Key? key, required this.message, required this.isAgent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return message.sender != 'Me'
        ? Container(
            margin: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 20.r,
                      backgroundImage: message.isBot && message.sender != "Me"
                          ? const AssetImage("assets/images/logo.jpeg")
                              as ImageProvider
                          : !message.isBot && message.sender != "Me"
                              ? NetworkImage(message.imageUrl ?? "")
                              : const AssetImage("assets/agent.png"),
                    ),
                    SizedBox(
                        width:
                            8), // Add some spacing between avatar and message
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: 200,
                        decoration: BoxDecoration(
                          color:
                              Colors.grey[300], // Light grey background color
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: (message.imageUrl != null)
                                  ? EdgeInsets.only(bottom: 10)
                                  : null,
                              child: Text(
                                message.text,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: "K2D",
                                    fontSize: 13,
                                    color: Colors.black), // Black text color
                              ),
                            ),
                            if (message.imageUrl != null)
                              Image.network(
                                message.imageUrl!,

                                fit: BoxFit
                                    .cover, // Adjust the image height as needed
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 25),
                  width: 80, // Adjust the size as needed
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.time ?? "",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: "K2D"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 20, left: 130),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add some spacing between avatar and message
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: 200,
                        decoration: BoxDecoration(
                          color:
                              AppColors.primary, // Light grey background color
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              margin: (message.imageUrl != null)
                                  ? EdgeInsets.only(bottom: 10)
                                  : null,
                              child: Text(
                                message.text,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: "K2D",
                                    fontSize: 13,
                                    color: Colors.white), // Black text color
                              ),
                            ),
                            if (message.imageUrl != null)
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => FullImageModal(
                                        imageUrl: message.imageUrl!),
                                  );
                                },
                                child: Image.network(
                                  message.imageUrl!,

                                  fit: BoxFit
                                      .cover, // Adjust the image height as needed
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      // Replace with your avatar logic
                      child: Icon(Icons.person),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, right: 26),
                  width: 80, // Adjust the size as needed
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.time ?? "",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      message.isRead ?? false
                          ? SvgPicture.asset(
                              'assets/2-tick.svg',
                            )
                          : SvgPicture.asset(
                              'assets/1-tick.svg',
                            )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
