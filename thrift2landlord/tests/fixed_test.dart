import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';

void main() {
  print('♔ Fixed Pawn Capture Test ♔\n');

  final game = ChessGame();

  // Setup the correct position for pawn capture
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

    // Now test e4xd4 capture (White recaptures)
    print('\nTesting e4xd4 recapture...');
    final result2 = game.move(Position(4, 4), Position(4, 3)); // e4xd4

    if (result2) {
      print('✅ White recapture successful!');
      print('\nPosition after e4xd4:');
      game.printGame();
    } else {
      print('❌ White recapture failed!');
    }
  } else {
    print('❌ Black capture failed!');
  }
}
