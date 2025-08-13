import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/engine/pieces/queen.dart';
import '../lib/core/engine/pieces/king.dart';

void main() {
  print('Comprehensive Check Validation Test...');

  final game = ChessGame();

  // Clear the board
  for (int row = 0; row < 8; row++) {
    for (int col = 0; col < 8; col++) {
      game.board.setPiece(Position(row, col), null);
    }
  }

  // Set up the exact position from our game
  // White queen on f8, Black king on h8
  game.board.setPiece(Position(0, 5), Queen(PieceColor.white)); // Queen on f8
  game.board
      .setPiece(Position(0, 7), King(PieceColor.black)); // Black king on h8

  // Set turn to Black
  game.turn = PieceColor.black;

  print('Board setup:');
  game.board.printBoard();
  print('Current turn: ${game.turn}');

  // Test if Black king is in check
  final kingInCheck = game.board.isKingInCheck(PieceColor.black);
  print('Is Black king in check? $kingInCheck');

  // Test the exact move from our game: h8 to g8
  final from = Position(0, 7); // h8
  final to = Position(0, 6); // g8

  print('\nTesting move: h8 to g8');
  print('From: $from, To: $to');

  final pieceAtFrom = game.board.getPiece(from);
  print('Piece at from (h8): ${pieceAtFrom?.symbol} (${pieceAtFrom?.color})');

  if (pieceAtFrom != null) {
    final legalMoves = pieceAtFrom.getLegalMoves(from, game.board);
    print('Legal moves for king: $legalMoves');
    print('Is g8 in legal moves? ${legalMoves.contains(to)}');
  }

  // Simulate the move step by step to understand what happens
  print('\n--- Simulating move step by step ---');

  // Step 1: Execute the move
  final captured = game.board.getPiece(to);
  game.board.movePiece(from, to);
  print('Step 1: Move executed');
  game.board.printBoard();

  // Step 2: Check if king is in check after move
  final kingInCheckAfterMove = game.board.isKingInCheck(PieceColor.black);
  print('Step 2: Is Black king in check after move? $kingInCheckAfterMove');

  // Step 3: If in check, undo the move
  if (kingInCheckAfterMove) {
    print('Step 3: Undoing move because king is in check');
    game.board.movePiece(to, from);
    if (captured != null) {
      game.board.setPiece(to, captured);
    }
    print('Move undone');
    game.board.printBoard();
  }

  // Now test the actual move method
  print('\n--- Testing actual move method ---');
  final moveResult = game.move(from, to);
  print('Move result: $moveResult');

  print('\nFinal board state:');
  game.board.printBoard();

  if (moveResult) {
    print('❌ BUG: Move was accepted despite leaving king in check!');
  } else {
    print('✅ CORRECT: Move was rejected because it leaves king in check');
  }
}
