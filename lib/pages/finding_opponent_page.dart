import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thai_chess_mobile/providers/socket_method.dart';
import 'package:thai_chess_mobile/socketio/socket_method.dart';
import 'package:thai_chess_mobile/widgets/app_bar.dart';
import 'package:thai_chess_mobile/widgets/button_primary.dart';
import 'package:thai_chess_mobile/widgets/chess_board.dart';

class WaitingRoomPage extends ConsumerStatefulWidget {
  const WaitingRoomPage({super.key});
  static const route = 'waiting-room';

  @override
  ConsumerState<WaitingRoomPage> createState() => _WaitingRoomPageState();
}

class _WaitingRoomPageState extends ConsumerState<WaitingRoomPage>
    with SingleTickerProviderStateMixin {
  late SocketMethod socketClient;
  late AnimationController _controller;
  late Animation<double> _animation;
  void _onCancel() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    print('init state');
    socketClient = ref.read(socketClientProvider);
    socketClient.initConnection();
    print('init connection');
    socketClient.socket.emit('find-opponent', {
      'playerId': DateTime.now().toString(),
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    socketClient.closeConnection();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createRoomEvent = ref.watch(createRoomStreamProvider);
    final joinRoomEvent = ref.watch(joinRoomStreamProvider);

    if (joinRoomEvent.hasValue) {
      return const Text('joined');
    }
    return Scaffold(
      appBar: const MyAppBar(),
      body: createRoomEvent.when(
        data: (data) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.primary
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chess Waiting Room',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  const ChessBoard(),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      'Searching for opponent...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ButtonPrimary(
                    onClick: _onCancel,
                    label: 'Cancel',
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, _) {
          print(error.toString());
          return const Text('error');
        },
        loading: () => const Text('Loading...'),
      ),
    );
  }
}
