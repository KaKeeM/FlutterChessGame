import 'package:flutter/material.dart';
import 'package:flutter_chess_game/components/piece.dart';
import 'package:flutter_chess_game/components/square.dart';
import 'package:flutter_chess_game/helper/helper_methods.dart';
import 'package:flutter_chess_game/values/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  
  State<GameScreen> createState() => _gameScreenState();
}

class _gameScreenState extends State<GameScreen> {
  late List<List<ChessPiece?>> board;

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GridView.builder(
        gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemCount: 8 * 8,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          int row = index ~/8;
          int col = index % 8;

          return Square(
            isWhite: isWhite(index),
            piece: board[row][col],
          );
       },
      ),
    );
  }
}