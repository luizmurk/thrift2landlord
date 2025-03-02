part of './../../index.dart';

class FullImageModal extends StatelessWidget {
  final String imageUrl;

  FullImageModal({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Dialog(
        child: Image.network(imageUrl),
      ),
    );
  }
}
