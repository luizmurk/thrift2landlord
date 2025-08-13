import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';

void main() {
  print('♔ Final Pawn Capture Test ♔\n');

  final game = ChessGame();

  // Setup a position where pawns can capture diagonally forward
  print('Setting up position...');
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(6, 5), Position(4, 5)); // f2 f4
  game.move(Position(1, 5), Position(3, 5)); // f7 f5

  print('\nPosition after f7 f5:');
  game.printGame();

  // Now test e4xf5 capture (White captures Black pawn at f5)
  print('\nTesting e4xf5 capture...');
  final result = game.move(Position(4, 4), Position(3, 5)); // e4xf5

  if (result) {
    print('✅ White capture successful!');
    print('\nPosition after e4xf5:');
    game.printGame();
  } else {
    print('❌ White capture failed!');

    // Debug
    final e4Piece = game.board.getPiece(Position(4, 4));
    if (e4Piece != null) {
      final legalMoves = e4Piece.getLegalMoves(Position(4, 4), game.board);
      print('Legal moves for ${e4Piece.name} at e4: $legalMoves');

      // Check what's at f5
      final f5Piece = game.board.getPiece(Position(3, 5));
      print(
          'Piece at f5: ${f5Piece?.name ?? "empty"} (${f5Piece?.color ?? "none"})');
    }
  }
}
