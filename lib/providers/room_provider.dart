import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thai_chess_mobile/models/player.dart';
import 'package:thai_chess_mobile/models/room.dart';

final roomProvider =
    StateNotifierProvider.autoDispose<RoomNotifier, Room?>((ref) {
  return RoomNotifier();
});

class RoomNotifier extends StateNotifier<Room?> {
  RoomNotifier() : super(null);

  void createRoom(String roomId) {
    final Player player = Player(id: roomId);

    state = Room(roomId: roomId, p1: player, currentBoard: []);
  }
}
