import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:thai_chess_mobile/socketio/socket_client.dart';
import 'package:thai_chess_mobile/socketio/socket_method.dart';
import 'package:thai_chess_mobile/utils/config.dart';

final socketClientProvider = Provider<SocketMethod>((ref) {
  final String host = AppConfig.getBaseUrl();
  final IO.Socket client = SocketClient('http://$host:3000').socket;
  final SocketMethod method = SocketMethod(socket: client);

  return method;
});

final joinRoomStreamProvider =
    StreamProvider.autoDispose<Map<String, dynamic>>((ref) async* {
  final StreamController stream = StreamController();
  final SocketMethod socketMethod = ref.watch(socketClientProvider);
  socketMethod.socket.on(
    'join-room-success',
    (data) {
      stream.add(data);
    },
  );
  await for (final value in stream.stream) {
    yield value;
  }
});

final createRoomStreamProvider =
    StreamProvider.autoDispose<Map<String, dynamic>>((ref) async* {
  final StreamController stream = StreamController();
  final SocketMethod socketMethod = ref.watch(socketClientProvider);
  socketMethod.socket.on(
    'create-room-success',
    (data) {
      stream.add(data);
    },
  );
  await for (final value in stream.stream) {
    yield value;
  }
});
