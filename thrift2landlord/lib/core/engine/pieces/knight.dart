import '../abstract_base_class/piece.dart';
import '../base_classes/board.dart';
import '../base_classes/position.dart';
import '../../models/enums/pieces.dart';

class Knight extends Piece {
  Knight(super.color);
  bool hasMoved = false;

  bool get pieceHasMoved => hasMoved;
  @override
  String get name => 'Knight';

  @override
  String get symbol => color == PieceColor.white ? 'N' : 'n';

  @override
  @override
  List<Position> getLegalMoves(Position from, Board board) {
    List<Position> moves = [];

    final offsets = [
      Position(-2, -1),
      Position(-2, 1),
      Position(-1, -2),
      Position(-1, 2),
      Position(1, -2),
      Position(1, 2),
      Position(2, -1),
      Position(2, 1),
    ];

    for (final offset in offsets) {
      final target = from + offset;
      if (!target.isValid()) continue;

      final piece = board.getPiece(target);
      if (piece == null || piece.color != color) {
        moves.add(target);
      }
    }

    return moves;
  }
}
