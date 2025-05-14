class Position {
  final int row; // 0 - 7
  final int col; // 0 - 7

  Position(this.row, this.col);

  bool isValid() => row >= 0 && row < 8 && col >= 0 && col < 8;

  @override
  bool operator ==(Object other) =>
      other is Position && row == other.row && col == other.col;

  @override
  int get hashCode => row * 8 + col;

  @override
  String toString() => '(${row}, ${col})';

  /// Overload the `+` operator to support vector-like addition
  Position operator +(Position other) {
    return Position(row + other.row, col + other.col);
  }
}
