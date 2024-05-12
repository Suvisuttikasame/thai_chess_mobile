import 'package:thai_chess_mobile/models/player.dart';

class Room {
  final String roomId;
  final Player p1;
  final Player p2;
  final Player turn;
  final List<dynamic> currentBoard;

  Room({
    required this.roomId,
    required this.p1,
    required this.p2,
    required this.turn,
    required this.currentBoard,
  });

  static Map<int, dynamic> getBoardVMap(List<dynamic> currentBoard) {
    Map<int, dynamic> board = {
      for (var element in currentBoard) element['position']: element
    };
    return board;
  }
}
