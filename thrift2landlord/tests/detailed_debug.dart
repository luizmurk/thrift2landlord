import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';

void main() {
  print('♔ Detailed Pawn Capture Debug ♔\n');

  final game = ChessGame();

  // Setup position
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(6, 3), Position(4, 3)); // d2 d4
  game.move(Position(3, 4), Position(4, 3)); // e5xd4

  print('Position:');
  game.printGame();

  // Debug pawn at e4
  final e4Pos = Position(4, 4);
  final e4Piece = game.board.getPiece(e4Pos);

  if (e4Piece != null) {
    print('\nPawn at e4 (${e4Pos}):');
    print('- Color: ${e4Piece.color}');
    print('- Direction: ${e4Piece.color == PieceColor.white ? -1 : 1}');

    // Test capture positions manually
    final direction = e4Piece.color == PieceColor.white ? -1 : 1;

    for (var dCol in [-1, 1]) {
      final capturePos = Position(e4Pos.row + direction, e4Pos.col + dCol);
      final target = game.board.getPiece(capturePos);

      print('\nDiagonal ${dCol > 0 ? "right" : "left"}:');
      print('- Position: $capturePos');
      print(
          '- Target: ${target?.name ?? "empty"} (${target?.color ?? "none"})');
      print('- Is valid: ${capturePos.isValid()}');
      print(
          '- Can capture: ${target != null && target.color != e4Piece.color}');
    }

    // Test the actual getLegalMoves
    final legalMoves = e4Piece.getLegalMoves(e4Pos, game.board);
    print('\nLegal moves from getLegalMoves: $legalMoves');

    // Check if d4 should be in legal moves
    final d4Pos = Position(4, 3);
    print(
        '\nShould d4 (${d4Pos}) be in legal moves? ${legalMoves.contains(d4Pos)}');
  }
}
