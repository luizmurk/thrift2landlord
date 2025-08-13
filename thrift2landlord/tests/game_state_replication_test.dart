import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/engine/pieces/pawn.dart';
import '../lib/core/engine/pieces/queen.dart';
import '../lib/core/engine/pieces/knight.dart';

void main() {
  print('Replicating Game State Bug Test...');

  final game = ChessGame();

  // Replicate the exact game state from our game
  // Clear the board first
  for (int row = 0; row < 8; row++) {
    for (int col = 0; col < 8; col++) {
      game.board.setPiece(Position(row, col), null);
    }
  }

  // Set up the position from our game:
  // White: pawn on f4, pawn on g3, knights on e7 and e5, bishop on g2, king on f1, queen on f8
  // Black: pawn on g6, knight on c1, knight on f6, king on h8

  // White pieces
  game.board.setPiece(Position(4, 5), Pawn(PieceColor.white)); // f4
  game.board.setPiece(Position(5, 6), Pawn(PieceColor.white)); // g3
  game.board.setPiece(Position(1, 4), Knight(PieceColor.white)); // e7
  game.board.setPiece(Position(3, 4), Knight(PieceColor.white)); // e5
  game.board
      .setPiece(Position(6, 6), Pawn(PieceColor.white)); // g2 (bishop position)
  game.board
      .setPiece(Position(7, 5), Pawn(PieceColor.white)); // f1 (king position)
  game.board.setPiece(Position(0, 5), Queen(PieceColor.white)); // f8

  // Black pieces
  game.board.setPiece(Position(2, 6), Pawn(PieceColor.black)); // g6
  game.board.setPiece(Position(7, 2), Knight(PieceColor.black)); // c1
  game.board.setPiece(Position(2, 5), Knight(PieceColor.black)); // f6
  game.board
      .setPiece(Position(0, 7), Pawn(PieceColor.black)); // h8 (king position)

  // Set turn to black
  game.turn = PieceColor.black;

  print('Replicated game state:');
  game.board.printBoard();
  print('Current turn: ${game.turn}');

  // Test the problematic move: h8 to h7
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
    print('Legal moves for piece at h8: $legalMoves');
    print('Is h7 in legal moves? ${legalMoves.contains(to)}');
  }

  final moveResult = game.move(from, to);
  print('Move result: $moveResult');

  print('\nBoard after move attempt:');
  game.board.printBoard();

  if (moveResult) {
    print('❌ BUG: Piece was able to move to h7 despite having a piece there!');
  } else {
    print('✅ CORRECT: Piece cannot move to h7 when occupied');
  }
}
