import '../abstract_base_class/piece.dart';
import '../base_classes/board.dart';
import '../base_classes/board_with_game_ref.dart';
import '../base_classes/position.dart';
import '../../models/enums/pieces.dart';

class Pawn extends Piece {
  Pawn(super.color);
  bool hasMoved = false;

  bool get pieceHasMoved => hasMoved;

  @override
  String get name => 'Pawn';

  @override
  String get symbol => color == PieceColor.white ? 'P' : 'p';

  @override
  List<Position> getLegalMoves(Position from, Board board) {
    final moves = <Position>[];
    final direction = color == PieceColor.white ? -1 : 1;

    // One square forward
    final oneAhead = Position(from.row + direction, from.col);
    if (board.getPiece(oneAhead) == null) {
      moves.add(oneAhead);

      // Two squares forward (from starting position)
      final twoAhead = Position(from.row + 2 * direction, from.col);
      if (!hasMoved && board.getPiece(twoAhead) == null) {
        moves.add(twoAhead);
      }
    }

    // Captures
    for (var dCol in [-1, 1]) {
      final capturePos = Position(from.row + direction, from.col + dCol);
      final target = board.getPiece(capturePos);

      if (target != null && target.color != color) {
        moves.add(capturePos);
      }
    }

    // --- En Passant captures ---
    if (board is BoardWithGameReference) {
      final game = (board as BoardWithGameReference).game;
      final lastMove = game.lastPawnDoubleMovePosition;

      if (lastMove != null && from.row == lastMove.row) {
        for (var dCol in [-1, 1]) {
          if (from.col + dCol == lastMove.col) {
            final capturePos = Position(from.row + direction, from.col + dCol);
            moves.add(capturePos);
          }
        }
      }
    }

    return moves;
  }
}
