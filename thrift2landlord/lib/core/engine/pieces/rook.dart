import '../abstract_base_class/piece.dart';
import '../base_classes/board.dart';
import '../base_classes/position.dart';
import '../../models/enums/pieces.dart';

class Rook extends Piece {
  Rook(super.color);
  bool hasMoved = false;

  bool get pieceHasMoved => hasMoved;
  @override
  String get name => 'Rook';

  @override
  String get symbol => color == PieceColor.white ? 'R' : 'r';

  @override
  List<Position> getLegalMoves(Position from, Board board) {
    List<Position> moves = [];

    // Horizontal and vertical directions
    final directions = [
      Position(0, 1), // right
      Position(0, -1), // left
      Position(1, 0), // down
      Position(-1, 0), // up
    ];

    for (final dir in directions) {
      var current = from + dir;

      while (current.isValid()) {
        final piece = board.getPiece(current);
        if (piece == null) {
          moves.add(current);
        } else {
          if (piece.color != color) {
            moves.add(current); // Can capture enemy piece
          }
          break; // Stop moving after hitting anything
        }
        current = current + dir;
      }
    }

    return moves;
  }
}
