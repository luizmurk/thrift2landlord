import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/engine/pieces/queen.dart';
import '../lib/core/engine/pieces/king.dart';
import '../lib/core/engine/pieces/knight.dart';

void main() {
  print('Analyzing Position After White f7 f8...');

  final game = ChessGame();

  // Clear the board
  for (int row = 0; row < 8; row++) {
    for (int col = 0; col < 8; col++) {
      game.board.setPiece(Position(row, col), null);
    }
  }

  // Current position after White f7 f8
  game.board.setPiece(Position(0, 5), Queen(PieceColor.white)); // Queen on f8
  game.board
      .setPiece(Position(0, 7), King(PieceColor.black)); // Black king on h8
  game.board
      .setPiece(Position(2, 5), Knight(PieceColor.black)); // Black knight on f6

  // Set turn to Black
  game.turn = PieceColor.black;

  print('Current position:');
  game.board.printBoard();
  print('Current turn: ${game.turn}');

  // Check if Black king is in check
  final kingInCheck = game.board.isKingInCheck(PieceColor.black);
  print('Is Black king in check? $kingInCheck');

  // Find all legal moves for Black
  print('\nFinding legal moves for Black...');
  List<Position> allLegalMoves = [];

  for (var entry in game.board.pieces.entries) {
    final piece = entry.value;
    if (piece.color == PieceColor.black) {
      final from = entry.key;
      final legalMoves = piece.getLegalMoves(from, game.board);

      print('${piece.name} at ${from}: $legalMoves');

      // Test each move to see if it's actually legal (doesn't leave king in check)
      for (final to in legalMoves) {
        final captured = game.board.getPiece(to);
        game.board.movePiece(from, to);

        final leavesKingInCheck = game.board.isKingInCheck(PieceColor.black);

        // Undo move
        game.board.movePiece(to, from);
        if (captured != null) {
          game.board.setPiece(to, captured);
        }

        if (!leavesKingInCheck) {
          allLegalMoves.add(to);
          print('  ✅ ${from} to ${to} is legal');
        } else {
          print('  ❌ ${from} to ${to} leaves king in check');
        }
      }
    }
  }

  print('\nAll legal moves for Black: $allLegalMoves');

  if (allLegalMoves.isEmpty) {
    print('❌ CHECKMATE! Black has no legal moves.');
  } else {
    print('✅ Black can escape check with these moves: $allLegalMoves');
  }
}
