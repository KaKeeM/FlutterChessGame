import 'package:flutter/material.dart';
import 'package:flutter_chess_game/components/piece.dart';
import 'package:flutter_chess_game/components/square.dart';
import 'package:flutter_chess_game/helper/helper_methods.dart';
import 'package:flutter_chess_game/values/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<ChessPiece?>> board;

  //the current selected piece on the chess board
  // if no piece is selected, this is null
  ChessPiece? selectedPiece;

  //the row index of the selected piece
  // default value meaning no piece is selected
  int selectedRow = -1;

  int selectedCol = -1;

  //a list of valid moves for the currently selected piece
  // each move is represented as a list with 2 elements: row and col
  List<List<int>> validMoves = [];

  List<ChessPiece> whitePiecesTaken = [];

  List<ChessPiece> blackPiecesTaken = [];

  @override
  void initState(){
    super.initState();
    _initializeBoard();
  }
  void _initializeBoard() {


    //initialize board with nulls, no pieces in those positions
    List<List<ChessPiece?>> newBoard =
      List.generate(8, (index) => List.generate(8, (index) => null));

    //place pawns
    for (int i = 0; i < 8; i++){
      newBoard[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: false,
        imagePath: 'lib/images/black-pawn.png',
      );
      newBoard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        imagePath: 'lib/images/black-pawn.png',
      );
    }

    //PLACE ROOKS
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/black-rook.png',
    );
    newBoard[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      imagePath: 'lib/images/black-rook.png',
    );
    newBoard[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'lib/images/black-rook.png',
    );
    newBoard[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      imagePath: 'lib/images/black-rook.png',
    );

    //place the knights
    newBoard[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'lib/images/black-knight.png',
    );
    newBoard[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      imagePath: 'lib/images/black-knight.png',
    );
    newBoard[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'lib/images/black-knight.png',
    );
    newBoard[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      imagePath: 'lib/images/black-knight.png',
    );

    //PLACE BISHOP
    newBoard[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'lib/images/black-bishop.png',
    );
    newBoard[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      imagePath: 'lib/images/black-bishop.png',
    );
    newBoard[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'lib/images/black-bishop.png',
    );
    newBoard[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      imagePath: 'lib/images/black-bishop.png',
    );

    //place queens
    newBoard[0][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: false,
      imagePath: 'lib/images/black-queen.png',
    );
    newBoard[7][4] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: true,
      imagePath: 'lib/images/black-queen.png',
    );

    //place kings
    newBoard[0][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: false,
      imagePath: 'lib/images/black-king.png',
    );
    newBoard[7][3] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: true,
      imagePath: 'lib/images/black-king.png',
    );

    board = newBoard;
  }

  void pieceSelected(int row, int col){
    setState((){
      //selected piece if teh is a piece in that position
      if (selectedPiece == null && board[row][col] != null) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }else if (board[row][col] != null &&
        board[row][col]!.isWhite == selectedPiece!.isWhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }
      //se a paeca for selecionada e o movimento for valido
      else if(selectedPiece != null &&
          validMoves.any((element) => element[0] == row && element[1] == col)){
        movePiece(row, col);
      }

      //if a piece is selected, calculate is valid moves
      validMoves = calculatedRowValidMoves(selectedRow,selectedCol,selectedPiece);

    });
  }

  //calculate raw valid moves
  List<List<int>> calculatedRowValidMoves(int row, int col, ChessPiece? piece){
    List<List<int>> candidateMoves = [];

    if (piece == null) {
      return [];
    }

    int direction = piece!.isWhite? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
      // Movements for the pawn (already implemented in your code)
      // Can move forward
        if (isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }

        // Can move 2 squares forward if in the initial position
        if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        // Can capture diagonally to the left
        if (isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }

        // Can capture diagonally to the right
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col + 1]);
        }
        break;

      case ChessPieceType.rook:
      // Rook can move horizontally and vertically
        for (var dRow in [-1, 1]) {
          var r = row + dRow;
          while (isInBoard(r, col) && (board[r][col] == null || board[r][col]!.isWhite != piece.isWhite)) {
            candidateMoves.add([r, col]);
            if (board[r][col] != null) break;
            r += dRow;
          }
        }
        for (var dCol in [-1, 1]) {
          var c = col + dCol;
          while (isInBoard(row, c) && (board[row][c] == null || board[row][c]!.isWhite != piece.isWhite)) {
            candidateMoves.add([row, c]);
            if (board[row][c] != null) break;
            c += dCol;
          }
        }
        break;

      case ChessPieceType.knight:
      // Knight can move in "L" shape
        for (var offset in [
          [2, 1], [2, -1], [-2, 1], [-2, -1],
          [1, 2], [1, -2], [-1, 2], [-1, -2]
        ]) {
          var r = row + offset[0];
          var c = col + offset[1];
          if (isInBoard(r, c) && (board[r][c] == null || board[r][c]!.isWhite != piece.isWhite)) {
            candidateMoves.add([r, c]);
          }
        }
        break;

      case ChessPieceType.bishop:
      // Bishop can move diagonally
        for (var direction in [
          [1, 1], [1, -1], [-1, 1], [-1, -1]
        ]) {
          var r = row + direction[0];
          var c = col + direction[1];
          while (isInBoard(r, c) && (board[r][c] == null || board[r][c]!.isWhite != piece.isWhite)) {
            candidateMoves.add([r, c]);
            if (board[r][c] != null) break;
            r += direction[0];
            c += direction[1];
          }
        }
        break;

      case ChessPieceType.queen:
      // Queen can move in all directions (rook + bishop combined)
        for (var direction in [
          [1, 0], [-1, 0], [0, 1], [0, -1], // Rook directions
          [1, 1], [1, -1], [-1, 1], [-1, -1] // Bishop directions
        ]) {
          var r = row + direction[0];
          var c = col + direction[1];
          while (isInBoard(r, c) && (board[r][c] == null || board[r][c]!.isWhite != piece.isWhite)) {
            candidateMoves.add([r, c]);
            if (board[r][c] != null) break;
            r += direction[0];
            c += direction[1];
          }
        }
        break;

      case ChessPieceType.king:
      // King can move one square in any direction
        for (var direction in [
          [1, 0], [-1, 0], [0, 1], [0, -1], // Vertical and horizontal
          [1, 1], [1, -1], [-1, 1], [-1, -1] // Diagonals
        ]) {
          var r = row + direction[0];
          var c = col + direction[1];
          if (isInBoard(r, c) && (board[r][c] == null || board[r][c]!.isWhite != piece.isWhite)) {
            candidateMoves.add([r, c]);
          }
        }
        break;
    }
    return candidateMoves;
  }
  void movePiece(int newRow, int newCol){
    //se o novo lugar for uma peça inimigo
    if (board[newRow][newRow] != null){
       //adicionar a peça pega na lista
      var capturedPiece = board[newRow][newCol];
      if (capturedPiece!.isWhite){
        whitePiecesTaken.add(capturedPiece);
      } else {
        blackPiecesTaken.add(capturedPiece);
      }

    }

    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          //white pieces takes
          Expanded(
            child: GridView.builder(
              itemCount: whitePiecesTaken.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                itemBuilder: (context, index) => DeadPiece(),
            ),
          ),


          //chess board
          Expanded(
            child: GridView.builder(
            gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
            itemCount: 8 * 8,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              int row = index ~/8;
              int col = index % 8;
  
              //check if the square is selected
              bool isSelected = selectedRow == row && selectedCol == col;
  
              //check if is valid move
              bool isValidMove = false;
              for (var position in validMoves) {
                if (position[0] == row && position[1] == col){
                  isValidMove = true;
                }
              }
  
              return Square(
                isWhite: isWhite(index),
                piece: board[row][col],
                isSelected: isSelected,
                isValidMove: isValidMove,
                onTap: () => pieceSelected(row, col),
              );
            },
            ),
          ),
        ]
      )
    );
  }
}