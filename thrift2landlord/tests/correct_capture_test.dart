import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';

void main() {
  print('♔ Correct Chess Capture Test ♔\n');

  final game = ChessGame();

  // Setup a proper chess position for pawn capture
  print('Setting up position...');
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(6, 3), Position(4, 3)); // d2 d4

  print('\nPosition after d2 d4:');
  game.printGame();

  // Now test e5xd4 capture (Black captures White pawn at d4)
  print('\nTesting e5xd4 capture...');
  final result = game.move(Position(3, 4), Position(4, 3)); // e5xd4

  if (result) {
    print('✅ Black capture successful!');
    print('\nPosition after e5xd4:');
    game.printGame();

    // Now test e4xf5 capture (White captures Black pawn at e5 diagonally)
    print('\nTesting e4xf5 capture...');
    final result2 = game.move(Position(4, 4), Position(3, 5)); // e4xf5

    if (result2) {
      print('✅ White diagonal capture successful!');
      print('\nPosition after e4xf5:');
      game.printGame();
    } else {
      print('❌ White diagonal capture failed!');

      // Debug
      final e4Piece = game.board.getPiece(Position(4, 4));
      if (e4Piece != null) {
        final legalMoves = e4Piece.getLegalMoves(Position(4, 4), game.board);
        print('Legal moves for ${e4Piece.name} at e4: $legalMoves');
      }
    }
  } else {
    print('❌ Black capture failed!');
  }
}
