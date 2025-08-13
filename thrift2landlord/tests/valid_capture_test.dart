import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';

void main() {
  print('♔ Valid Pawn Capture Test ♔\n');

  final game = ChessGame();

  // Setup a valid position for pawn capture
  print('Setting up position...');
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(6, 5), Position(4, 5)); // f2 f4

  print('\nPosition after f2 f4:');
  game.printGame();

  // Now test e5xf4 capture (Black captures White pawn at f4)
  print('\nTesting e5xf4 capture...');
  final result = game.move(Position(3, 4), Position(4, 5)); // e5xf4

  if (result) {
    print('✅ Black capture successful!');
    print('\nPosition after e5xf4:');
    game.printGame();

    // Now test e4xf4 capture (White recaptures)
    print('\nTesting e4xf4 recapture...');
    final result2 = game.move(Position(4, 4), Position(4, 5)); // e4xf4

    if (result2) {
      print('✅ White recapture successful!');
      print('\nPosition after e4xf4:');
      game.printGame();
    } else {
      print('❌ White recapture failed!');

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
