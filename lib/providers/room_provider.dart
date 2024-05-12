import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thai_chess_mobile/models/piece.dart';
import 'package:thai_chess_mobile/models/player.dart';
import 'package:thai_chess_mobile/models/room.dart';
import 'package:thai_chess_mobile/providers/game_provider.dart';

final roomProvider = StateNotifierProvider<RoomNotifier, Room?>((ref) {
  return RoomNotifier(ref);
});

class RoomNotifier extends StateNotifier<Room?> {
  RoomNotifier(this.ref) : super(null);
  final Ref ref;

  void createRoom(Map<String, dynamic> data) {
    final player1 = Player(id: data['player1']['playerId']);
    final player2 = Player(id: data['player2']['playerId']);
    final turn = Player(id: data['turn']['player']['playerId']);
    state = Room(
      roomId: data['roomId'],
      p1: player1,
      p2: player2,
      turn: turn,
      currentBoard: data['currentBoard'],
    );
    final board = Room.getBoardVMap(state!.currentBoard);
    ref.read(gameProvider.notifier).initState(board, Side.black);
  }
}
