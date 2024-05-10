import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  static SocketClient? _instance;
  late IO.Socket socket;

  factory SocketClient(String uri) {
    _instance ??= SocketClient._internal(uri);
    return _instance!;
  }

  SocketClient._internal(String uri) {
    socket = IO.io(
      uri,
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );
  }

  static SocketClient? get instance => _instance;
}
