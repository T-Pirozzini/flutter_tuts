import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tetris_tut/piece.dart';
import 'package:flutter_tetris_tut/pixel.dart';
import 'package:flutter_tetris_tut/values.dart';

/*
GAME BOARD

This is a 2x2 grid with null representing an empty space
A non empty space will have the color to represent the landed pieces

*/

// create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.T);

  // current score
  int currentScore = 0;

  @override
  void initState() {
    super.initState();

    // start the game when app starts
    startGame();
  }

  void startGame() {
    // initialize the current piece
    currentPiece.initializePiece();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  // game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          // clear lines
          clearLines();

          // check landing
          checkLanding();

          // move piece down
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  // check for collision in a future position
  bool checkCollision(Direction direction) {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the row and column
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      // adjust the row and column based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if the piece is our of bounds (either too low or too far to the left or right)
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }

      // check if the position is occupied
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }

    // if no collision, return false
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(Direction.down)) {
      // mark position as occupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        // calculate the row and column
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;

        if (row >= 0 && col >= 0) {
          // mark the position as occupied
          gameBoard[row][col] = currentPiece.type;
        }
      }
      // once landed, create a new piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // create a random object to generate random tetromino types
    Random rand = Random();

    // create a new piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
  }

  // move left
  void moveLeft() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // move right
  void moveRight() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear lines
  void clearLines() {
    // step 1: loop through each row of the game board from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      // step 2: Initialize a variable to track if the row is full
      bool rowIsFull = true;

      // step 3: check if the row is full (all columns are occupied)
      for (int col = 0; col < rowLength; col++) {
        // if there's an empty column, set rowIsFull to false and break out of the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      // step 4: if the row is full, clear the row and shift rows down
      if (rowIsFull) {
        // step 5: move all rows above the cleared row down by one position
        for (int r = row; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // step 6: set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);

        // step 7: increase the score
        currentScore++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * colLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength),
              itemBuilder: (context, index) {
                // get row and column of each index
                int row = (index / rowLength).floor();
                int col = (index % rowLength);

                // current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                    child: index,
                  );
                }
                // landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                      color: tetronimoColors[tetrominoType], child: '');
                }
                // blank pixel
                else {
                  return Pixel(
                    color: Colors.grey[900],
                    child: index,
                  );
                }
              },
            ),
          ),

          // SCORE
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 50.0),
            child: Text(
              'Score: $currentScore',
              style: const TextStyle(color: Colors.white),
            ),
          ),

          // GAME CONTROLS
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // left
                IconButton(
                  onPressed: moveLeft,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                // rotate
                IconButton(
                  onPressed: rotatePiece,
                  icon: const Icon(
                    Icons.rotate_right,
                    color: Colors.white,
                  ),
                ),
                // right
                IconButton(
                  onPressed: moveRight,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
