import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';

void main() {
  print('♔ Corrected Capture Test ♔\n');

  final game = ChessGame();

  // Setup the correct position for e4xd5 capture
  print('Setting up position...');
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(6, 3), Position(4, 3)); // d2 d4
  game.move(Position(3, 4), Position(4, 3)); // e5xd4

  print('\nPosition after e5xd4:');
  game.printGame();

  // Now test e4xd4 capture
  print('\nTesting e4xd4 capture...');
  final result = game.move(Position(4, 4), Position(4, 3)); // e4xd4

  if (result) {
    print('✅ Capture successful!');
    print('\nPosition after e4xd4:');
    game.printGame();
  } else {
    print('❌ Capture failed!');

    // Debug the position
    final e4Piece = game.board.getPiece(Position(4, 4));
    final d4Piece = game.board.getPiece(Position(4, 3));

    print('\nDebug info:');
    print(
        'Piece at e4: ${e4Piece?.name ?? "empty"} (${e4Piece?.color ?? "none"})');
    print(
        'Piece at d4: ${d4Piece?.name ?? "empty"} (${d4Piece?.color ?? "none"})');

    if (e4Piece != null) {
      final legalMoves = e4Piece.getLegalMoves(Position(4, 4), game.board);
      print('Legal moves for ${e4Piece.name} at e4: $legalMoves');
    }
  }
}
