part of './../../index.dart';

class ImagePreviewDialog extends StatefulWidget {
  final String imageFilePath;
  final VoidCallback onCancel;
  final VoidCallback onSend;

  const ImagePreviewDialog({
    Key? key,
    required this.imageFilePath,
    required this.onCancel,
    required this.onSend,
  }) : super(key: key);

  @override
  _ImagePreviewDialogState createState() => _ImagePreviewDialogState();
}

class _ImagePreviewDialogState extends State<ImagePreviewDialog> {
  final ChatController controller = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Preview Image'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(File(widget.imageFilePath)),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: controller.textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  final message = controller.textEditingController.text;
                  if (message.isNotEmpty) {
                    widget.onSend();
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a message.')),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.onCancel,
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
