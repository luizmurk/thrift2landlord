import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/engine/pieces/king.dart';

void main() {
  print('♔ Debug Testing Specific Issues ♔\n');

  debugCaptureIssue();
  debugCheckIssue();
}

void debugCaptureIssue() {
  print('=== Debugging Capture Issue ===');
  final game = ChessGame();

  print('\nSetting up position for e4xd4 capture...');
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(6, 3), Position(4, 3)); // d2 d4
  game.move(Position(3, 4), Position(4, 3)); // e5xd4

  print('\nPosition before e4xd4:');
  game.printGame();

  // Check what piece is at e4
  final e4Piece = game.board.getPiece(Position(4, 4));
  print(
      '\nPiece at e4: ${e4Piece?.name ?? "empty"} (${e4Piece?.color ?? "none"})');

  // Check what piece is at d4
  final d4Piece = game.board.getPiece(Position(4, 3));
  print(
      'Piece at d4: ${d4Piece?.name ?? "empty"} (${d4Piece?.color ?? "none"})');

  // Check legal moves for pawn at e4
  if (e4Piece != null) {
    final legalMoves = e4Piece.getLegalMoves(Position(4, 4), game.board);
    print('Legal moves for ${e4Piece.name} at e4: $legalMoves');
    print('Is d4 in legal moves? ${legalMoves.contains(Position(4, 3))}');
  }

  print('\nAttempting e4xd4...');
  final result = game.move(Position(4, 4), Position(4, 3));
  print('Result: ${result ? "SUCCESS" : "FAILED"}');

  if (result) {
    print('\nPosition after e4xd4:');
    game.printGame();
  }
}

void debugCheckIssue() {
  print('\n=== Debugging Check Issue ===');
  final game = ChessGame();

  print('\nSetting up position for check...');
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(7, 5), Position(3, 1)); // Bc4

  print('\nPosition after Bc4:');
  game.printGame();

  // Find Black king position
  Position? blackKingPos;
  for (var entry in game.board.pieces.entries) {
    if (entry.value is King && entry.value.color == PieceColor.black) {
      blackKingPos = entry.key;
      break;
    }
  }
  print('\nBlack king position: $blackKingPos');

  // Check if bishop can attack king
  final bishopPos = Position(3, 1);
  final bishop = game.board.getPiece(bishopPos);
  if (bishop != null) {
    final bishopMoves = bishop.getLegalMoves(bishopPos, game.board);
    print('Bishop legal moves: $bishopMoves');
    print('Can bishop attack king? ${bishopMoves.contains(blackKingPos)}');
  }

  // Test check detection
  final inCheck = game.board.isKingInCheck(PieceColor.black);
  print('\nIs Black in check? $inCheck');
}
