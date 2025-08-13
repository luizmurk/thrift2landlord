import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';

void main() {
  print('♔ Board Coordinate Test ♔\n');

  final game = ChessGame();

  print('Initial board:');
  game.printGame();

  // Test specific positions
  print('\nTesting specific positions:');
  print(
      'e2 (should be white pawn): ${game.board.getPiece(Position(6, 4))?.symbol ?? "empty"}');
  print(
      'e4 (should be empty): ${game.board.getPiece(Position(4, 4))?.symbol ?? "empty"}');
  print(
      'd4 (should be empty): ${game.board.getPiece(Position(4, 3))?.symbol ?? "empty"}');
  print(
      'e7 (should be black pawn): ${game.board.getPiece(Position(1, 4))?.symbol ?? "empty"}');
  print(
      'e5 (should be empty): ${game.board.getPiece(Position(3, 4))?.symbol ?? "empty"}');

  // Make a move and test again
  print('\nAfter e2 e4:');
  game.move(Position(6, 4), Position(4, 4));
  game.printGame();

  print('\nTesting positions after e2 e4:');
  print(
      'e2 (should be empty): ${game.board.getPiece(Position(6, 4))?.symbol ?? "empty"}');
  print(
      'e4 (should be white pawn): ${game.board.getPiece(Position(4, 4))?.symbol ?? "empty"}');
}
