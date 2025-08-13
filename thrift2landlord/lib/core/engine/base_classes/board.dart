import '../abstract_base_class/piece.dart';
import '../../models/enums/pieces.dart';
import '../pieces/bishop.dart';
import '../pieces/king.dart';
import '../pieces/knight.dart';
import '../pieces/pawn.dart';
import '../pieces/queen.dart';
import '../pieces/rook.dart';
import 'position.dart';

class Board {
  // 8x8 board grid with nullable pieces
  List<List<Piece?>> squares = List.generate(
    8,
    (_) => List.filled(8, null),
  );

  /// Get the piece at a given position
  Piece? getPiece(Position pos) => squares[pos.row][pos.col];

  Map<Position, Piece> get pieces {
    final map = <Position, Piece>{};
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        final piece = squares[row][col];
        if (piece != null) {
          map[Position(row, col)] = piece;
        }
      }
    }
    return map;
  }

  /// Place a piece at a given position
  void setPiece(Position pos, Piece? piece) {
    squares[pos.row][pos.col] = piece;
  }

  /// Move a piece from one square to another
  void movePiece(Position from, Position to) {
    final piece = getPiece(from);
    setPiece(to, piece); // Move to destination
    setPiece(from, null);
    piece!.hasMoved = true; // Clear original square
  }

  /// Set up the board with initial pawns (for now, just pawns)
  void initialize() {
    for (int col = 0; col < 8; col++) {
      // Place white pawns on row 6
      setPiece(Position(6, col), Pawn(PieceColor.white));

      setPiece(Position(7, 0), Rook(PieceColor.white));
      setPiece(Position(7, 7), Rook(PieceColor.white));
      setPiece(Position(7, 2), Bishop(PieceColor.white));
      setPiece(Position(7, 5), Bishop(PieceColor.white));
      setPiece(Position(7, 1), Knight(PieceColor.white));
      setPiece(Position(7, 6), Knight(PieceColor.white));
      setPiece(Position(7, 3), Queen(PieceColor.white));
      setPiece(Position(7, 4), King(PieceColor.white)); // E1

      // Place black pawns on row 1
      setPiece(Position(1, col), Pawn(PieceColor.black)); // A1
      setPiece(Position(0, 0), Rook(PieceColor.black));
      setPiece(Position(0, 7), Rook(PieceColor.black));
      // C1
      setPiece(Position(0, 2), Bishop(PieceColor.black));
      setPiece(Position(0, 5), Bishop(PieceColor.black));
      setPiece(Position(0, 1), Knight(PieceColor.black));
      setPiece(Position(0, 6), Knight(PieceColor.black));

      setPiece(Position(0, 3), Queen(PieceColor.black));
      setPiece(Position(0, 4), King(PieceColor.black)); // E8
    }

    // Later: add rooks, bishops, etc.
  }

  bool isKingInCheck(PieceColor color) {
    // 1. Find the king's position
    Position? kingPos;
    for (var entry in pieces.entries) {
      if (entry.value is King && entry.value.color == color) {
        kingPos = entry.key;
        break;
      }
    }

    if (kingPos == null) return false; // King not found (shouldn't happen)

    // 2. Check if any enemy piece can attack this position
    for (var entry in pieces.entries) {
      final piece = entry.value;
      if (piece.color != color) {
        final legalMoves = piece.getLegalMoves(entry.key, this);
        if (legalMoves.contains(kingPos)) {
          return true;
        }
      }
    }

    return false;
  }

  /// Print board in text form (for debugging)
  void printBoard() {
    print('    a   b   c   d   e   f   g   h');
    print('   ───────────────────────────────');
    for (int row = 0; row < 8; row++) {
      String line = '${8 - row} │';
      for (int col = 0; col < 8; col++) {
        final piece = getPiece(Position(row, col));
        if (piece == null) {
          line += ' . ';
        } else {
          line += ' ${piece.symbol} ';
        }
      }
      line += '│ ${8 - row}';
      print(line);
    }
    print('   ───────────────────────────────');
    print('    a   b   c   d   e   f   g   h');
  }
}
