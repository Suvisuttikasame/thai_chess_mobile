import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  const ChessBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemCount: 64,
        itemBuilder: (BuildContext context, int index) {
          bool isWhite = (index + ((index / 8).floor())) % 2 == 0;
          return Container(
            color: isWhite ? Colors.white : Colors.grey.shade700,
          );
        },
      ),
    );
  }
}
