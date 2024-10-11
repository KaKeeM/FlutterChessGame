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
  ChessPiece myPawn = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: false,
      imagePath: 'lib/images/black-pawn.png');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemCount: 8 * 8,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Square(
          isWhite: isWhite(index),
          piece: myPawn,
        )
      ),
    );
  }
}