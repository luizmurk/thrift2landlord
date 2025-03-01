import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thrift2landlord/core/components/index.dart';

class CustomFilePicker extends StatefulWidget {
  final Function(XFile) onFileSelected;
  final String buttonText;

  const CustomFilePicker({
    Key? key,
    required this.onFileSelected,
    required this.buttonText,
  }) : super(key: key);

  @override
  _CustomFilePickerState createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  String? fileName;

  Future<void> _pickFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        fileName = file.name;
      });
      widget.onFileSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: CustomSecondaryButton(
            text: widget.buttonText,
            onPressed: _pickFile,
          ),
        ),
        if (fileName != null) ...[
          SizedBox(height: 8),
          Text(
            'Selected File: $fileName',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ],
    );
  }
}
