part of './../../index.dart';

class CustomBottomAppBar extends StatefulWidget {
  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  final ChatController controller = Get.find<ChatController>();
  final FocusNode _focusNode = FocusNode();
  bool showAdditionalOptions = false;
  File imageFile = File("");
  bool showSendIcon = false;
  bool raiseInput = false;

  @override
  void initState() {
    super.initState();
    // Add listener to the FocusNode
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // Dispose of the FocusNode when no longer needed
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // Check if the FocusNode has focus
    if (_focusNode.hasFocus) {
      setState(() {
        raiseInput = !raiseInput;
      });
    } else {
      setState(() {
        raiseInput = !raiseInput;
      });
    }
  }

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      showDialog(
        context: context,
        builder: (context) => ImagePreviewDialog(
          imageFilePath: pickedFile.path,
          onCancel: () {
            imageFile = File("");
            Navigator.pop(context);
          },
          onSend: () {
            controller.sendMessage(
              isAI: false,
              message: controller.textEditingController.text,
              imageFile: File(pickedFile.path),
            );
          },
        ),
      );
    }
  }

  void _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      showDialog(
        context: context,
        builder: (context) => ImagePreviewDialog(
          imageFilePath: pickedFile.path,
          onCancel: () {
            imageFile = File("");
            Navigator.pop(context);
          },
          onSend: () {
            controller.sendMessage(
              isAI: false,
              message: controller.textEditingController.text,
              imageFile: File(pickedFile.path),
            );
          },
        ),
      );
    }
  }

  void _pickDocument() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final documentFile = File(result.files.single.path!);
      // Add functionality to handle the picked document
      //controller.addDocument(documentFile);
      // Optionally, you can display the name of the picked document
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Picked Document'),
          content: Text(result.files.single.name),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  void _toggleAdditionalOptions() {
    setState(() {
      showAdditionalOptions = !showAdditionalOptions;
    });
  }

  void _toggleSendIcon(String value) {
    setState(() {
      showSendIcon = value.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: AppColors.light,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          margin: !raiseInput
              ? !showAdditionalOptions
                  ? EdgeInsets.only(bottom: 50.h)
                  : null
              : EdgeInsets.only(bottom: 300.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _toggleAdditionalOptions();
                },
                child: !raiseInput
                    ? Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: Icon(
                          showAdditionalOptions ? Icons.cancel : Icons.add,
                          color: Colors.white,
                        ),
                      )
                    : SizedBox(),
              ),
              SizedBox(width: 8),
              Expanded(
                child: MessageInputField(
                  controller: controller.textEditingController,
                  focusNode: _focusNode,
                  onChanged: _toggleSendIcon,
                  hintText: 'Type a message',
                ),
              ),
              Row(
                children: [
                  showSendIcon
                      ? IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            controller
                                .sendMessage(
                                    isAI: false,
                                    message: "",
                                    imageFile: imageFile)
                                .then((value) {
                              _toggleSendIcon(
                                  controller.textEditingController.text);
                              return imageFile = File("");
                            });
                          },
                        )
                      : Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _pickImage();
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.light,
                                child: SvgPicture.asset(
                                  'assets/images/camera.svg',
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: AppColors.light,
                              child: SvgPicture.asset(
                                'assets/images/mic.svg',
                              ),
                            ),
                          ],
                        ),
                ],
              )
            ],
          ),
        ),
        showAdditionalOptions ? _additionalOptions() : Container(),
      ],
    );
  }

  Widget _additionalOptions() {
    return Container(
      color: AppColors.light,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      margin: EdgeInsets.only(bottom: 50.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                _pickImage();
              },
              child: CircleAvatar(
                backgroundColor: AppColors.light,
                child: SvgPicture.asset(
                  'assets/images/add_image.svg',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                _pickImageFromCamera();
              },
              child: CircleAvatar(
                backgroundColor: AppColors.light,
                child: SvgPicture.asset(
                  'assets/images/camera.svg',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                _pickDocument();
              },
              child: CircleAvatar(
                backgroundColor: AppColors.light,
                child: SvgPicture.asset(
                  'assets/images/add_document.svg',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.light,
              child: SvgPicture.asset(
                'assets/images/add_image.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
