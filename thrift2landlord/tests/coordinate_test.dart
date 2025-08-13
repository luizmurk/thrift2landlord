import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';

void main() {
  print('♔ Coordinate System Test ♔\n');

  final game = ChessGame();

  // Test coordinate mapping
  print('Testing coordinate mapping:');
  print('e4 = Position(4, 4) = ${Position(4, 4)}');
  print('d4 = Position(4, 3) = ${Position(4, 3)}');
  print('e5 = Position(3, 4) = ${Position(3, 4)}');

  // Setup the position
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(6, 3), Position(4, 3)); // d2 d4
  game.move(Position(3, 4), Position(4, 3)); // e5xd4

  print('\nPosition after e5xd4:');
  game.printGame();

  // Test pawn at e4
  final e4Pos = Position(4, 4);
  final e4Piece = game.board.getPiece(e4Pos);
  print('\nPiece at e4 (${e4Pos}): ${e4Piece?.name ?? "empty"}');

  if (e4Piece != null) {
    final legalMoves = e4Piece.getLegalMoves(e4Pos, game.board);
    print('Legal moves: $legalMoves');

    // Check each diagonal capture
    final direction = e4Piece.color == PieceColor.white ? -1 : 1;
    for (var dCol in [-1, 1]) {
      final capturePos = Position(e4Pos.row + direction, e4Pos.col + dCol);
      final target = game.board.getPiece(capturePos);
      print(
          'Diagonal ${dCol > 0 ? "right" : "left"}: $capturePos = ${target?.name ?? "empty"} (${target?.color ?? "none"})');
    }
  }
}
