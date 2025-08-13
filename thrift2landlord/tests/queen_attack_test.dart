import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/engine/pieces/queen.dart';
import '../lib/core/engine/pieces/king.dart';

void main() {
  print('Testing Queen Attack from f7 to h8...');

  final game = ChessGame();

  // Clear the board
  for (int row = 0; row < 8; row++) {
    for (int col = 0; col < 8; col++) {
      game.board.setPiece(Position(row, col), null);
    }
  }

  // Set up position: White queen on f7, Black king on h8
  game.board.setPiece(Position(1, 5), Queen(PieceColor.white)); // Queen on f7
  game.board
      .setPiece(Position(0, 7), King(PieceColor.black)); // Black king on h8

  print('Board setup:');
  game.board.printBoard();

  // Test queen's legal moves
  final queenPos = Position(1, 5); // f7
  final queen = game.board.getPiece(queenPos);
  final queenMoves = queen!.getLegalMoves(queenPos, game.board);

  print('\nQueen on f7 legal moves: $queenMoves');

  // Check if h8 (0,7) is in queen's moves
  final h8Pos = Position(0, 7);
  print('Is h8 in queen\'s moves? ${queenMoves.contains(h8Pos)}');

  // Test if Black king is in check
  final kingInCheck = game.board.isKingInCheck(PieceColor.black);
  print('Is Black king in check? $kingInCheck');

  // Manually trace the diagonal from f7 to h8
  print('\n--- Manual diagonal trace from f7 to h8 ---');
  var current = Position(1, 5); // f7
  final direction = Position(-1, 2); // up-right diagonal

  print('Starting at: $current');
  current = current + direction;
  print('After one step: $current');

  if (current.isValid()) {
    final piece = game.board.getPiece(current);
    print('Piece at $current: ${piece?.symbol} (${piece?.color})');
  }

  // Test the exact diagonal path
  print('\n--- Testing diagonal path ---');
  var testPos = Position(1, 5); // f7
  final testDir = Position(-1, 2); // up-right

  for (int i = 1; i <= 2; i++) {
    testPos = testPos + testDir;
    print('Step $i: $testPos (valid: ${testPos.isValid()})');
    if (testPos.isValid()) {
      final piece = game.board.getPiece(testPos);
      print('  Piece: ${piece?.symbol} (${piece?.color})');
    }
  }
}
