import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';

void main() {
  print('♔ Chess Engine Comprehensive Testing ♔\n');

  testInvalidMoves();
  testCaptures();
  testSpecialMoves();
  testCheckScenarios();
}

void testInvalidMoves() {
  print('=== Testing Invalid Moves ===');
  final game = ChessGame();

  // Test 1: Moving from empty square
  print('\n1. Testing move from empty square: e3 e4');
  bool result =
      game.move(Position(5, 4), Position(4, 4)); // e3 e4 (e3 is empty)
  print(result ? '❌ BUG: Invalid move accepted!' : '✅ Correctly rejected!');

  // Test 2: Moving opponent's piece
  print('\n2. Testing moving opponent piece: e7 e5 (as White)');
  result = game.move(Position(1, 4), Position(3, 4)); // Black's move as White
  print(result ? '❌ BUG: Opponent move accepted!' : '✅ Correctly rejected!');

  // Test 3: Illegal piece movement
  print(
      '\n3. Testing illegal pawn move: e2 e5 (2 squares forward from non-starting position)');
  game.move(Position(6, 4), Position(4, 4)); // First move e2 e4
  game.move(Position(1, 4), Position(3, 4)); // Black responds e7 e5
  result =
      game.move(Position(4, 4), Position(2, 4)); // e4 e6 (illegal pawn move)
  print(
      result ? '❌ BUG: Illegal pawn move accepted!' : '✅ Correctly rejected!');

  print('\n=== Invalid Move Tests Complete ===\n');
}

void testCaptures() {
  print('=== Testing Captures ===');
  final game = ChessGame();

  // Setup position for capture test
  print('\nSetting up capture position...');
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(6, 3), Position(4, 3)); // d2 d4
  game.move(Position(3, 4), Position(4, 3)); // e5xd4 (capture)

  print('\nPosition after e5xd4:');
  game.printGame();

  // Test capture
  print('\n4. Testing capture: e4xd4');
  bool result = game.move(Position(4, 4), Position(4, 3)); // e4xd4
  print(result ? '✅ Capture successful!' : '❌ Capture failed!');

  if (result) {
    print('\nPosition after e4xd4:');
    game.printGame();
  }

  print('\n=== Capture Tests Complete ===\n');
}

void testSpecialMoves() {
  print('=== Testing Special Moves ===');
  final game = ChessGame();

  // Test pawn double move
  print('\n5. Testing pawn double move: e2 e4');
  bool result = game.move(Position(6, 4), Position(4, 4)); // e2 e4
  print(
      result ? '✅ Double pawn move successful!' : '❌ Double pawn move failed!');

  // Test knight movement
  print('\n6. Testing knight move: g1 f3');
  result = game.move(Position(7, 6), Position(5, 5)); // g1 f3
  print(result ? '✅ Knight move successful!' : '❌ Knight move failed!');

  print('\n=== Special Move Tests Complete ===\n');
}

void testCheckScenarios() {
  print('=== Testing Check Scenarios ===');
  final game = ChessGame();

  // Setup a position where White can give check
  print('\nSetting up check position...');
  game.move(Position(6, 4), Position(4, 4)); // e2 e4
  game.move(Position(1, 4), Position(3, 4)); // e7 e5
  game.move(Position(7, 5), Position(3, 1)); // Bc4 (Bishop to c4)

  print('\nPosition after Bc4:');
  game.printGame();

  // Test if Black is in check
  print('\n7. Testing check detection');
  bool inCheck = game.board.isKingInCheck(PieceColor.black);
  print(inCheck ? '✅ Check detected correctly!' : '❌ Check not detected!');

  if (inCheck) {
    print('♔ Black is in check! ♔');
  }

  print('\n=== Check Tests Complete ===\n');
}
