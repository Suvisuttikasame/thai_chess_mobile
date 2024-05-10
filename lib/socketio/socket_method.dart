import 'package:socket_io_client/socket_io_client.dart';

enum Event {
  findOpponent('find-opponent');

  final String name;
  const Event(this.name);
}

class SocketMethod {
  final Socket socket;

  SocketMethod({required this.socket});

  void initConnection() {
    socket.connect();
    print('run init connection');
  }

  void closeConnection() {
    socket.close();
  }
}
