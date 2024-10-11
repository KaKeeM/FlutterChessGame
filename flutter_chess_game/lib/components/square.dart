import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_game/components/piece.dart';

import '../values/colors.dart';

class Square extends StatelessWidget{
  final bool isWhite;
  final ChessPiece? piece;

  const Square({
    super.key,
    required this.isWhite,
    required this.piece,
  });

  Widget build(BuildContext context){
    return Container(
      color: isWhite ? foregroundColor : backgroundColor,
      child: piece != null
          ? Image.asset(
            piece!.imagePath,
            color: piece!.isWhite ? Colors.white : Colors.black,
      ) : null,
    );
  }
}