import '../abstract_base_class/piece.dart';
import '../base_classes/board.dart';
import '../base_classes/position.dart';
import '../../models/enums/pieces.dart';

class Bishop extends Piece {
  Bishop(super.color);

  bool get pieceHasMoved => hasMoved;
  @override
  String get name => 'Bishop';

  @override
  String get symbol => color == PieceColor.white ? 'B' : 'b';

  @override
  @override
  List<Position> getLegalMoves(Position from, Board board) {
    List<Position> moves = [];

    // Diagonal directions
    final directions = [
      Position(1, 1), // ↘ down-right
      Position(1, -1), // ↙ down-left
      Position(-1, 1), // ↗ up-right
      Position(-1, -1), // ↖ up-left
    ];

    for (final dir in directions) {
      var current = from + dir;

      while (current.isValid()) {
        final piece = board.getPiece(current);
        if (piece == null) {
          moves.add(current);
        } else {
          if (piece.color != color) {
            moves.add(current); // Can capture
          }
          break; // Blocked by any piece
        }
        current = current + dir;
      }
    }

    return moves;
  }
}
