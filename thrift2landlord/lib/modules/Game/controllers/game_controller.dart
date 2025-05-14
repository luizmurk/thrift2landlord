part of '../index.dart';

class GameController {
  final ChessGame game = ChessGame();

  GameController() {
    // Initialize the game or perform any setup if needed
  }
  void move(Position from, Position to) {
    game.printGame();
    if (!from.isValid() || !to.isValid()) {
      throw ArgumentError('Both "from" and "to" must be valid positions.');
    }
    // Add logic for handling the move here
    game.move(from, to);
    game.printGame();
  }
}
