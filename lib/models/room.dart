import 'package:thai_chess_mobile/models/player.dart';

class Room {
  final String roomId;
  final Player p1;
  final Player? p2;
  final List<String> currentBoard;

  Room({
    required this.roomId,
    required this.p1,
    this.p2,
    required this.currentBoard,
  });
}
