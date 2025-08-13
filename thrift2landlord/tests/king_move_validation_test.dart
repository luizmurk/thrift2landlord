import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/engine/pieces/pawn.dart';

void main() {
  print('Testing King Move Validation Bug...');

  final game = ChessGame();

  // Set up a specific position to test the bug
  // Place a black king on h8 and a black pawn on h7
  game.board.setPiece(Position(0, 7), null); // Clear h8
  game.board.setPiece(Position(1, 7), null); // Clear h7

  // Place black king on h8
  final blackKing =
      game.board.getPiece(Position(0, 4)); // Get the black king from e8
  game.board.setPiece(Position(0, 4), null); // Remove from e8
  game.board.setPiece(Position(0, 7), blackKing); // Place on h8

  // Place black pawn on h7
  final blackPawn = Pawn(PieceColor.black);
  game.board.setPiece(Position(1, 7), blackPawn); // Place black pawn on h7

  // Set turn to black
  game.turn = PieceColor.black;

  print('Board setup:');
  game.board.printBoard();
  print('Current turn: ${game.turn}');

  // Test if king can move to h7 (should be invalid)
  final from = Position(0, 7); // h8
  final to = Position(1, 7); // h7

  print('\nTesting move: h8 to h7');
  print('From: $from, To: $to');

  final pieceAtFrom = game.board.getPiece(from);
  final pieceAtTo = game.board.getPiece(to);

  print('Piece at from (h8): ${pieceAtFrom?.symbol} (${pieceAtFrom?.color})');
  print('Piece at to (h7): ${pieceAtTo?.symbol} (${pieceAtTo?.color})');

  if (pieceAtFrom != null) {
    final legalMoves = pieceAtFrom.getLegalMoves(from, game.board);
    print('Legal moves for king: $legalMoves');
    print('Is h7 in legal moves? ${legalMoves.contains(to)}');
  }

  final moveResult = game.move(from, to);
  print('Move result: $moveResult');

  print('\nBoard after move attempt:');
  game.board.printBoard();

  if (moveResult) {
    print(
        '❌ BUG: King was able to move to h7 despite having a black pawn there!');
  } else {
    print('✅ CORRECT: King cannot move to h7 when occupied by own piece');
  }
}
