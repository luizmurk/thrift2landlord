import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/engine/pieces/pawn.dart';

void main() {
  print('♔ Pawn Capture Debug Test ♔\n');

  final game = ChessGame();

  // Setup position
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(6, 3), Position(4, 3)); // d2 d4
  game.move(Position(3, 4), Position(4, 3)); // e5xd4

  print('Position after e5xd4:');
  game.printGame();

  // Check pawn at e4
  final e4Pos = Position(4, 4);
  final e4Piece = game.board.getPiece(e4Pos);

  if (e4Piece is Pawn) {
    print('\nPawn at e4:');
    print('- Color: ${e4Piece.color}');
    print('- Has moved: ${e4Piece.hasMoved}');
    print('- Piece has moved: ${e4Piece.pieceHasMoved}');

    final legalMoves = e4Piece.getLegalMoves(e4Pos, game.board);
    print('- Legal moves: $legalMoves');

    // Check if d4 is a valid capture
    final d4Pos = Position(4, 3);
    final d4Piece = game.board.getPiece(d4Pos);
    print(
        '\nTarget at d4: ${d4Piece?.name ?? "empty"} (${d4Piece?.color ?? "none"})');

    // Manual capture check
    final direction = e4Piece.color == PieceColor.white ? -1 : 1;
    final leftCapture = Position(e4Pos.row + direction, e4Pos.col - 1);
    final rightCapture = Position(e4Pos.row + direction, e4Pos.col + 1);

    print('Left capture position: $leftCapture');
    print('Right capture position: $rightCapture');
    print('d4 position: $d4Pos');

    print('Is d4 in left capture? ${leftCapture == d4Pos}');
    print('Is d4 in right capture? ${rightCapture == d4Pos}');
  }
}
