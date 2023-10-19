import 'package:flutter_tetris_tut/values.dart';

class Piece {
  // type fo tetris piece
  Tetromino type;

  Piece({required this.type});

  // the piece is just a list of integers
  List<int> position = [];

  // generate the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-26, -16, -6, -7];
        break;
      case Tetromino.I:
        position = [-26, -16, -6, 4];
        break;
      case Tetromino.O:
        position = [-26, -16, -15, -5];
        break;
      case Tetromino.S:
        position = [-26, -16, -15, -5];
        break;
      case Tetromino.Z:
        position = [-26, -16, -5, -4];
        break;
      case Tetromino.T:
        position = [-26, -16, -15, -5];
        break;
      default:
    }
  }

  // move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
    }
  }
}
