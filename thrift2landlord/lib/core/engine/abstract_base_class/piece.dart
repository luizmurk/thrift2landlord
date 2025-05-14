import '../base_classes/board.dart';
import '../base_classes/position.dart';
import '../../models/enums/pieces.dart';

abstract class Piece {
  final PieceColor color;

  bool hasMoved = false;

  Piece(this.color);

  String get name;

  String get symbol;

  /// Override in subclasses to define piece-specific moves
  List<Position> getLegalMoves(Position from, Board board);
}
