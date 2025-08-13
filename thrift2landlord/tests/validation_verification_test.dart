import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/engine/pieces/pawn.dart';
import '../lib/core/engine/pieces/king.dart';

void main() {
  print('Verifying Move Validation Works Correctly...');

  final game = ChessGame();

  // Clear the board
  for (int row = 0; row < 8; row++) {
    for (int col = 0; col < 8; col++) {
      game.board.setPiece(Position(row, col), null);
    }
  }

  // Test 1: King trying to move to square occupied by own piece
  print('\n=== Test 1: King vs Own Piece ===');
  game.board.setPiece(Position(0, 7), King(PieceColor.black)); // King on h8
  game.board
      .setPiece(Position(1, 7), Pawn(PieceColor.black)); // Black pawn on h7
  game.turn = PieceColor.black;

  game.board.printBoard();

  final moveResult1 = game.move(Position(0, 7), Position(1, 7));
  print('King h8 to h7 (blocked by own pawn): $moveResult1');

  if (!moveResult1) {
    print('✅ CORRECT: King cannot move to square occupied by own piece');
  } else {
    print('❌ BUG: King was able to move to square occupied by own piece');
  }

  // Test 2: Pawn trying to move to square occupied by own piece
  print('\n=== Test 2: Pawn vs Own Piece ===');
  game.board.setPiece(Position(0, 7), Pawn(PieceColor.black)); // Pawn on h8
  game.board
      .setPiece(Position(1, 7), Pawn(PieceColor.black)); // Black pawn on h7
  game.turn = PieceColor.black;

  game.board.printBoard();

  final moveResult2 = game.move(Position(0, 7), Position(1, 7));
  print('Pawn h8 to h7 (blocked by own pawn): $moveResult2');

  if (!moveResult2) {
    print('✅ CORRECT: Pawn cannot move to square occupied by own piece');
  } else {
    print('❌ BUG: Pawn was able to move to square occupied by own piece');
  }

  // Test 3: Pawn moving to empty square (should work)
  print('\n=== Test 3: Pawn to Empty Square ===');
  game.board.setPiece(Position(0, 7), Pawn(PieceColor.black)); // Pawn on h8
  game.board.setPiece(Position(1, 7), null); // Empty h7
  game.turn = PieceColor.black;

  game.board.printBoard();

  final moveResult3 = game.move(Position(0, 7), Position(1, 7));
  print('Pawn h8 to h7 (empty square): $moveResult3');

  if (moveResult3) {
    print('✅ CORRECT: Pawn can move to empty square');
  } else {
    print('❌ BUG: Pawn cannot move to empty square');
  }
}
