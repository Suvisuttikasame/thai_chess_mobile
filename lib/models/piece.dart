import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';

enum Side { white, black }

enum PieceName {
  rook,
  knight,
  queen,
  bishop,
  king,
  pawn,
}

class Piece {
  static Widget getWidget(String name, String side) {
    if (side == Side.black.name) {
      switch (PieceName.values.byName(name)) {
        case PieceName.pawn:
          return BlackPawn();
        case PieceName.rook:
          return BlackRook();
        case PieceName.knight:
          return BlackKnight();
        case PieceName.queen:
          return BlackQueen();
        case PieceName.bishop:
          return BlackBishop();
        case PieceName.king:
          return BlackKing();
      }
    } else {
      switch (PieceName.values.byName(name)) {
        case PieceName.pawn:
          return WhitePawn();
        case PieceName.rook:
          return WhiteRook();
        case PieceName.knight:
          return WhiteKnight();
        case PieceName.queen:
          return WhiteQueen();
        case PieceName.bishop:
          return WhiteBishop();
        case PieceName.king:
          return WhiteKing();
      }
    }
  }
}
