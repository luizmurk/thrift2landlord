part of './../../index.dart';

class CustomPopupMenu extends StatefulWidget {
  @override
  _CustomPopupMenuState createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  bool _isMenuVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: () {
            setState(() {
              _isMenuVisible = !_isMenuVisible;
            });
          },
        ),
        if (_isMenuVisible) Text(""),
      ],
    );
  }
}
