# Chess Engine Tests

This folder contains comprehensive tests for the chess engine functionality.

## Test Categories

### Basic Functionality Tests
- **`test_move.dart`** - Tests basic move functionality and turn switching
- **`test_scenarios.dart`** - Comprehensive test suite covering invalid moves, captures, special moves, and check scenarios

### Capture and Movement Tests
- **`final_capture_test.dart`** - Tests pawn diagonal captures with proper positioning
- **`valid_capture_test.dart`** - Tests pawn captures in valid chess positions
- **`correct_capture_test.dart`** - Tests pawn capture scenarios

### Debug and Validation Tests
- **`debug_test.dart`** - Debug tests for specific issues (capture and check detection)
- **`detailed_debug.dart`** - Detailed debugging of pawn capture logic
- **`pawn_debug.dart`** - Specific debugging for pawn movement and capture issues
- **`coordinate_test.dart`** - Tests the coordinate system and position mapping
- **`board_test.dart`** - Tests board initialization and piece placement

### Legacy/Development Tests
- **`corrected_test.dart`** - Corrected versions of earlier tests
- **`fixed_test.dart`** - Fixed versions of problematic tests

## Running Tests

### Using the Test Runner
```bash
# Run all tests
dart run tests/run_tests.dart all

# Run basic functionality tests
dart run tests/run_tests.dart basic

# Run capture and movement tests
dart run tests/run_tests.dart capture

# Run debug and validation tests
dart run tests/run_tests.dart debug
```

### Running Individual Tests
```bash
# Run a specific test
dart run tests/test_scenarios.dart
dart run tests/final_capture_test.dart
```

## Test Results Summary

### ✅ Working Features
- Turn switching and validation
- Invalid move detection
- Pawn movement (forward and double moves)
- Pawn diagonal captures
- Board display and coordinates
- Game state management

### 🔧 Issues Resolved
- **Turn switching bug** - Fixed order of `switchTurn()` and `checkGameStatus()`
- **RangeError in pawn movement** - Added position validation
- **Capture system** - Confirmed working correctly (was test setup issue)
- **Check detection** - Confirmed working correctly (bishop path was blocked)

### 📋 Test Coverage
- Basic piece movement validation
- Capture mechanics
- Invalid move rejection
- Turn management
- Board coordinate system
- Position validation
- Game state transitions

## Notes
- All tests are designed to be run independently
- Tests include detailed debug output for troubleshooting
- The coordinate system uses 0-based indexing with rows 0-7 and columns 0-7
- Board display shows ranks 8-1 (top to bottom) and files a-h (left to right)
