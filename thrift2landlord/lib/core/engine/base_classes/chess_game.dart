import '../../models/enums/game_status.dart';
import '../../models/enums/pieces.dart';
import '../abstract_base_class/piece.dart';
import '../pieces/king.dart';
import '../pieces/pawn.dart';
import '../pieces/queen.dart';
import 'board.dart';
import 'position.dart';

class ChessGame {
  final Board board = Board(); // The chess board
  PieceColor turn = PieceColor.white; // White starts first by rule
  GameStatus status = GameStatus.ongoing;
  PieceColor get currentTurn => turn;
  GameStatus get gameStatus => status;

  Position?
      lastPawnDoubleMovePosition; // Tracks the last double pawn move for en passant

  ChessGame() {
    board.initialize(); // Set up pawns (and later full setup)
  }

  /// Try to move a piece. Return true if the move is valid and executed.
  bool move(Position from, Position to) {
    final piece = board.getPiece(from);

    if (piece == null || piece.color != currentTurn) return false;

    final legalMoves = piece.getLegalMoves(from, board);
    if (!legalMoves.contains(to)) return false;

    final captured = board.getPiece(to);
    // --- Special: En Passant capture ---
    bool isEnPassant = false;
    if (piece is Pawn && captured == null && from.col != to.col) {
      // Moved diagonally to empty square = en passant
      isEnPassant = true;
    }
    board.movePiece(from, to);

    if (isEnPassant) {
      final dir = piece.color == PieceColor.white ? 1 : -1;
      final capturedPawnPos = Position(to.row + dir, to.col);
      board.setPiece(capturedPawnPos, null);
    }

    if (board.isKingInCheck(currentTurn)) {
      board.movePiece(to, from);
      if (captured != null) {
        board.setPiece(to, captured);
      }
      return false;
    }

    // --- Handle Pawn Promotion ---
    if (piece is Pawn) {
      if ((piece.color == PieceColor.white && to.row == 0) ||
          (piece.color == PieceColor.black && to.row == 7)) {
        promotePawn(to, Queen(piece.color)); // Promote to Queen by default
      }
    }

    // --- Handle Castling (already added previously) ---
    if (piece is King) {
      if ((to.col - from.col).abs() == 2) {
        if (to.col == 6) {
          board.movePiece(Position(from.row, 7), Position(from.row, 5));
        } else if (to.col == 2) {
          board.movePiece(Position(from.row, 0), Position(from.row, 3));
        }
      }
    }

    // --- Track double pawn move for en passant ---
    if (piece is Pawn && (to.row - from.row).abs() == 2) {
      lastPawnDoubleMovePosition = to;
    } else {
      lastPawnDoubleMovePosition = null;
    }

    switchTurn();
    checkGameStatus();
    return true;
  }

  void promotePawn(Position position, Piece newPiece) {
    board.setPiece(position, newPiece);
  }

  void checkGameStatus() {
    bool hasLegalMove = false;

    // For every piece the current player has
    for (final entry in board.pieces.entries) {
      final piece = entry.value;
      if (piece.color != currentTurn) continue;

      final from = entry.key;
      final legalMoves = piece.getLegalMoves(from, board);

      // For each legal move
      for (final to in legalMoves) {
        // Simulate the move
        final captured = board.getPiece(to);
        board.movePiece(from, to);

        // Check if after the move, king is still safe
        final kingInCheck = board.isKingInCheck(currentTurn);

        // Undo move
        board.movePiece(to, from);
        if (captured != null) {
          board.setPiece(to, captured);
        }

        if (!kingInCheck) {
          hasLegalMove = true;
          break;
        }
      }
      if (hasLegalMove) break;
    }

    final kingInCheck = board.isKingInCheck(currentTurn);

    if (kingInCheck && !hasLegalMove) {
      status = GameStatus.checkmate;
    } else if (!kingInCheck && !hasLegalMove) {
      status = GameStatus.stalemate;
    } else if (kingInCheck) {
      status = GameStatus.check;
    } else {
      status = GameStatus.ongoing;
    }
  }

  /// Switch to the other player's turn
  void switchTurn() {
    turn = turn == PieceColor.white ? PieceColor.black : PieceColor.white;
  }

  /// Print current board state (for debugging)
  void printGame() {
    print('\nCurrent Turn: $turn');
    board.printBoard();
  }
}
