import '../abstract_base_class/piece.dart';
import '../base_classes/board.dart';
import '../base_classes/position.dart';
import '../../models/enums/pieces.dart';

class Queen extends Piece {
  Queen(super.color);
  bool hasMoved = false;

  bool get pieceHasMoved => hasMoved;
  @override
  String get name => 'Queen';

  @override
  String get symbol => color == PieceColor.white ? 'Q' : 'q';

  @override
  List<Position> getLegalMoves(Position from, Board board) {
    List<Position> moves = [];

    // Queen = Rook (orthogonal) + Bishop (diagonal)
    final directions = [
      // Rook directions
      Position(0, 1), Position(0, -1), Position(1, 0), Position(-1, 0),
      // Bishop directions
      Position(1, 1), Position(1, -1), Position(-1, 1), Position(-1, -1),
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
          break; // Can't move past anything
        }

        current = current + dir;
      }
    }

    return moves;
  }
}
