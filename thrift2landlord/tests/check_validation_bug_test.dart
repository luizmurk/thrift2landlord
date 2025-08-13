import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/engine/pieces/queen.dart';
import '../lib/core/engine/pieces/king.dart';

void main() {
  print('Testing Check Validation Bug...');

  final game = ChessGame();

  // Clear the board
  for (int row = 0; row < 8; row++) {
    for (int col = 0; col < 8; col++) {
      game.board.setPiece(Position(row, col), null);
    }
  }

  // Set up a position where Black king is in check from White queen
  // White queen on f8, Black king on h8
  game.board.setPiece(Position(0, 5), Queen(PieceColor.white)); // Queen on f8
  game.board
      .setPiece(Position(0, 7), King(PieceColor.black)); // Black king on h8

  // Set turn to Black
  game.turn = PieceColor.black;

  print('Board setup:');
  game.board.printBoard();
  print('Current turn: ${game.turn}');

  // Test if Black king is in check (should be true)
  final kingInCheck = game.board.isKingInCheck(PieceColor.black);
  print('Is Black king in check? $kingInCheck');

  // Test invalid king move: h8 to g8 (should be rejected)
  final from = Position(0, 7); // h8
  final to = Position(0, 6); // g8

  print('\nTesting invalid king move: h8 to g8');
  print('From: $from, To: $to');

  final pieceAtFrom = game.board.getPiece(from);
  final pieceAtTo = game.board.getPiece(to);

  print('Piece at from (h8): ${pieceAtFrom?.symbol} (${pieceAtFrom?.color})');
  print('Piece at to (g8): ${pieceAtTo?.symbol} (${pieceAtTo?.color})');

  if (pieceAtFrom != null) {
    final legalMoves = pieceAtFrom.getLegalMoves(from, game.board);
    print('Legal moves for king: $legalMoves');
    print('Is g8 in legal moves? ${legalMoves.contains(to)}');
  }

  final moveResult = game.move(from, to);
  print('Move result: $moveResult');

  print('\nBoard after move attempt:');
  game.board.printBoard();

  if (moveResult) {
    print('❌ BUG: King was able to move to g8 despite being in check!');
  } else {
    print('✅ CORRECT: King cannot move to g8 when in check');
  }

  // Test if Black king is still in check after move attempt
  final stillInCheck = game.board.isKingInCheck(PieceColor.black);
  print('Is Black king still in check? $stillInCheck');
}
