import '../abstract_base_class/piece.dart';
import '../base_classes/board.dart';
import '../base_classes/position.dart';
import '../../models/enums/pieces.dart';
import 'rook.dart';

class King extends Piece {
  King(super.color);

  bool get pieceHasMoved => hasMoved;
  @override
  String get name => 'King';

  @override
  String get symbol => color == PieceColor.white ? 'K' : 'k';

  @override
  List<Position> getLegalMoves(Position from, Board board) {
    List<Position> moves = [];

    final directions = [
      Position(0, 1),
      Position(1, 0),
      Position(0, -1),
      Position(-1, 0),
      Position(1, 1),
      Position(-1, -1),
      Position(-1, 1),
      Position(1, -1),
    ];

    for (final dir in directions) {
      final target = from + dir;
      if (!target.isValid()) continue;

      final piece = board.getPiece(target);
      // Only allow moves to empty squares or squares occupied by enemy pieces
      if (piece == null || piece.color != color) {
        moves.add(target);
      }
    }

    // --- Castling ---
    if (!hasMoved) {
      // Kingside (short) castling
      final rookPosition = Position(from.row, 7);
      final rook = board.getPiece(rookPosition);
      if (rook is Rook && !rook.hasMoved) {
        final f1 = Position(from.row, from.col + 1);
        final g1 = Position(from.row, from.col + 2);

        if (board.getPiece(f1) == null && board.getPiece(g1) == null) {
          // Check if king passes through check will be done later
          moves.add(g1);
        }
      }

      // Queenside (long) castling
      final rookPositionQueen = Position(from.row, 0);
      final rookQueen = board.getPiece(rookPositionQueen);
      if (rookQueen is Rook && !rookQueen.hasMoved) {
        final d1 = Position(from.row, from.col - 1);
        final c1 = Position(from.row, from.col - 2);
        final b1 = Position(from.row, from.col - 3);

        if (board.getPiece(d1) == null &&
            board.getPiece(c1) == null &&
            board.getPiece(b1) == null) {
          moves.add(c1);
        }
      }
    }

    return moves;
  }
}
