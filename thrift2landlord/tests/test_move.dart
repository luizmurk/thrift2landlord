import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';

void main() {
  final game = ChessGame();

  print('♔ Initial Position ♔');
  game.printGame();

  print('\n♔ White moves: e2 e4 ♔');
  final success1 = game.move(Position(6, 4), Position(4, 4)); // e2 to e4

  if (success1) {
    print('✅ White move successful!');
    print('\n♚ Black moves: e7 e5 ♚');
    final success2 = game.move(Position(1, 4), Position(3, 4)); // e7 to e5

    if (success2) {
      print('✅ Black move successful!');
      print('\n♔ White moves: b1 c3 ♔');
      final success3 = game.move(Position(7, 1), Position(5, 2)); // b1 to c3

      if (success3) {
        print('✅ White move successful!');
        print('\n♚ Black moves: b8 c6 ♚');
        final success4 = game.move(Position(0, 1), Position(2, 2)); // b8 to c6

        if (success4) {
          print('✅ Black move successful!');
          print('\n♔ White moves: g1 f3 ♔');
          final success5 =
              game.move(Position(7, 6), Position(5, 5)); // g1 to f3

          if (success5) {
            print('✅ White move successful!');
            print('\n♚ Black moves: g8 f6 ♚');
            final success6 =
                game.move(Position(0, 6), Position(2, 5)); // g8 to f6

            if (success6) {
              print('✅ Black move successful!');
              print('\n♔ Testing invalid move: g1 h3 ♔');
              print('Note: g1 is empty, knight is at f3');
              final success7 = game.move(
                  Position(7, 6), Position(5, 7)); // g1 to h3 (invalid)

              if (success7) {
                print('❌ BUG: Invalid move was accepted!');
              } else {
                print('✅ Correctly rejected invalid move!');
              }
              print('\n♔ Current position (should be unchanged) ♔');
              game.printGame();
            } else {
              print('❌ Black move failed!');
            }
          } else {
            print('❌ White move failed!');
          }
        } else {
          print('❌ Black move failed!');
        }
      } else {
        print('❌ White move failed!');
      }
    } else {
      print('❌ Black move failed!');
    }
  } else {
    print('❌ White move failed!');
  }
}
