import 'dart:io';

void main(List<String> args) {
  print('♔ Chess Engine Test Runner ♔\n');

  if (args.isEmpty) {
    print('Available test categories:');
    print('  all        - Run all tests');
    print('  basic      - Basic functionality tests');
    print('  capture    - Capture and movement tests');
    print('  debug      - Debug and validation tests');
    print('\nUsage: dart run tests/run_tests.dart [category]');
    return;
  }

  final category = args[0].toLowerCase();

  switch (category) {
    case 'all':
      runAllTests();
      break;
    case 'basic':
      runBasicTests();
      break;
    case 'capture':
      runCaptureTests();
      break;
    case 'debug':
      runDebugTests();
      break;
    default:
      print('❌ Unknown test category: $category');
      print('Available categories: all, basic, capture, debug');
  }
}

void runAllTests() {
  print('Running all tests...\n');
  runBasicTests();
  runCaptureTests();
  runDebugTests();
}

void runBasicTests() {
  print('=== Basic Functionality Tests ===');
  runTest('test_move.dart');
  runTest('test_scenarios.dart');
  print('');
}

void runCaptureTests() {
  print('=== Capture and Movement Tests ===');
  runTest('final_capture_test.dart');
  runTest('valid_capture_test.dart');
  runTest('correct_capture_test.dart');
  print('');
}

void runDebugTests() {
  print('=== Debug and Validation Tests ===');
  runTest('debug_test.dart');
  runTest('detailed_debug.dart');
  runTest('pawn_debug.dart');
  runTest('coordinate_test.dart');
  runTest('board_test.dart');
  print('');
}

void runTest(String testFile) {
  print('Running $testFile...');
  try {
    final result = Process.runSync('dart', ['run', 'tests/$testFile']);
    if (result.exitCode == 0) {
      print('✅ $testFile completed successfully');
    } else {
      print('❌ $testFile failed with exit code ${result.exitCode}');
    }
  } catch (e) {
    print('❌ Error running $testFile: $e');
  }
  print('');
}
