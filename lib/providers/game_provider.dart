import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thai_chess_mobile/models/piece.dart';

final gameProvider = StateNotifierProvider<GameNotifier, Map<String, dynamic>>(
    (ref) => GameNotifier());

class GameNotifier extends StateNotifier<Map<String, dynamic>> {
  GameNotifier()
      : super({
          'movePiece': {},
          'footPrintMove': {},
          'board': {},
          'mode': 'regular',
          'side': Side.white,
        });

  void initState(Map<int, dynamic> board, Side side) {
    state = {...state, 'board': board, 'side': side};
  }

  void footPrintMove(Map<int, dynamic> move, Map<String, dynamic> piece) {
    state = {
      ...state,
      'movePiece': piece,
      'footPrintMove': move,
      'mode': 'readyToMove'
    };
  }

  void move(Map<int, dynamic> board) {
    state = {
      ...state,
      'movePiece': {},
      'footPrintMove': {},
      'mode': 'regular',
      'board': board
    };
  }

  void resetMove() {
    state = {
      ...state,
      'movePiece': {},
      'footPrintMove': {},
      'mode': 'regular',
    };
  }
}
