part of '../index.dart';

class Board extends StatelessWidget {
  final GameController _gameController = GameController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("properties"),
            ElevatedButton(
              onPressed: () {
                _gameController.move(Position(7, 0), Position(4, 0));
              },
              child: const Text("Move Pieces"),
            ),
          ],
        )));
  }
}
