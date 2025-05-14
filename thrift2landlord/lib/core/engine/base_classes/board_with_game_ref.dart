import 'board.dart';
import 'chess_game.dart';

class BoardWithGameReference extends Board {
  final ChessGame game;

  BoardWithGameReference(this.game);
}
