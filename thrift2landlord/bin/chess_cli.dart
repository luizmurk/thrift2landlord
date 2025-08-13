import 'dart:io';
import '../lib/core/engine/base_classes/chess_game.dart';
import '../lib/core/engine/base_classes/position.dart';
import '../lib/core/models/enums/pieces.dart';
import '../lib/core/models/enums/game_status.dart';

class ChessCLI {
  final ChessGame game = ChessGame();

  void run() {
    print('♔ Welcome to Chess CLI! ♔');
    print('Commands:');
    print('  move <from> <to>  - e.g., move e2 e4');
    print('  status            - show game status');
    print('  board             - show current board');
    print('  help              - show this help');
    print('  quit              - exit game');
    print('');

    while (true) {
      print(
          '\n${game.currentTurn == PieceColor.white ? "♔" : "♚"} ${game.currentTurn.toString().toUpperCase()}s turn');
      print('Game Status: ${game.gameStatus}');
      game.printGame();

      stdout.write('\nEnter command: ');
      final input = stdin.readLineSync()?.trim().toLowerCase();

      if (input == null || input.isEmpty) continue;

      if (input == 'quit' || input == 'exit') {
        print('Thanks for playing! ♔');
        break;
      } else if (input == 'help') {
        printHelp();
      } else if (input == 'status') {
        printStatus();
      } else if (input == 'board') {
        game.printGame();
      } else if (input.startsWith('move ')) {
        handleMove(input);
      } else {
        print('❌ Unknown command. Type "help" for available commands.');
      }
    }
  }

  void printHelp() {
    print('\n♔ Chess CLI Commands ♔');
    print('move <from> <to>  - Make a move (e.g., move e2 e4)');
    print('status            - Show current game status');
    print('board             - Display the current board');
    print('help              - Show this help message');
    print('quit              - Exit the game');
    print('\nMove Format:');
    print('  Use algebraic notation: e2, e4, a1, h8, etc.');
    print('  Files: a-h (left to right)');
    print('  Ranks: 1-8 (bottom to top)');
  }

  void printStatus() {
    print('\n♔ Game Status ♔');
    print('Current Turn: ${game.currentTurn.toString().toUpperCase()}');
    print('Game Status: ${game.gameStatus}');

    if (game.gameStatus == GameStatus.check) {
      print('⚠️  CHECK!');
    } else if (game.gameStatus == GameStatus.checkmate) {
      print(
          '♔ CHECKMATE! ${game.currentTurn == PieceColor.white ? "BLACK" : "WHITE"} wins!');
    } else if (game.gameStatus == GameStatus.stalemate) {
      print('🤝 STALEMATE! Game is a draw.');
    }
  }

  void handleMove(String input) {
    final parts = input.split(' ');
    if (parts.length != 3) {
      print('❌ Invalid move format. Use: move <from> <to> (e.g., move e2 e4)');
      return;
    }

    try {
      final fromPos = parsePosition(parts[1]);
      final toPos = parsePosition(parts[2]);

      if (fromPos == null || toPos == null) {
        print(
            '❌ Invalid position format. Use letters a-h and numbers 1-8 (e.g., e2)');
        return;
      }

      final success = game.move(fromPos, toPos);
      if (success) {
        print('✅ Move successful!');
      } else {
        print('❌ Invalid move! Try again.');
      }
    } catch (e) {
      print('❌ Error: $e');
    }
  }

  Position? parsePosition(String pos) {
    if (pos.length != 2) return null;

    final file = pos[0].toLowerCase();
    final rank = pos[1];

    if (file.compareTo('a') < 0 || file.compareTo('h') > 0) return null;
    if (rank.compareTo('1') < 0 || rank.compareTo('8') > 0) return null;

    final col = file.codeUnitAt(0) - 'a'.codeUnitAt(0);
    final row = 8 - int.parse(rank); // Convert to 0-based indexing

    return Position(row, col);
  }
}

void main() {
  final cli = ChessCLI();
  cli.run();
}
