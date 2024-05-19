import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thai_chess_mobile/models/piece.dart';
import 'package:thai_chess_mobile/models/room.dart';
import 'package:thai_chess_mobile/pages/game_page.dart';
import 'package:thai_chess_mobile/providers/game_provider.dart';
import 'package:thai_chess_mobile/providers/player_provider.dart';
import 'package:thai_chess_mobile/providers/room_provider.dart';
import 'package:thai_chess_mobile/providers/socket_provider.dart';
import 'package:thai_chess_mobile/socketio/socket_method.dart';
import 'package:thai_chess_mobile/widgets/app_bar.dart';
import 'package:thai_chess_mobile/widgets/body_outline.dart';
import 'package:thai_chess_mobile/widgets/button_primary.dart';
import 'package:thai_chess_mobile/widgets/chess_board.dart';
import 'package:thai_chess_mobile/widgets/error.dart';
import 'package:thai_chess_mobile/widgets/loading.dart';

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
    socketClient = ref.read(socketClientProvider);
    socketClient.initConnection();
    socketClient.socket.emit('find-opponent', {
      'playerId': ref.read(playerProvider)['id'],
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

    if (joinRoomEvent.hasValue && !joinRoomEvent.hasError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(roomProvider.notifier)
            .createRoom(joinRoomEvent.value!['room']);
        final board =
            Room.getBoardVMap(joinRoomEvent.value!['room']['currentBoard']);
        if (joinRoomEvent.value!['room']['player1']['playerId'] ==
            ref.read(playerProvider)['id']) {
          ref.read(gameProvider.notifier).initState(
              board,
              Side.values.firstWhere((element) =>
                  element.toString() ==
                  'Side.${joinRoomEvent.value!['room']['player1']['side']}'));
        } else {
          ref.read(gameProvider.notifier).initState(
              board,
              Side.values.firstWhere((element) =>
                  element.toString() ==
                  'Side.${joinRoomEvent.value!['room']['player2']['side']}'));
        }
        Future.delayed(
          const Duration(seconds: 1),
        );
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 2000),
            pageBuilder: (_, __, ___) => const GamePage(),
            transitionsBuilder: (_, animation, __, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      });
    }

    return Scaffold(
      appBar: const MyAppBar(),
      body: joinRoomEvent.hasValue && !joinRoomEvent.hasError
          ? BodyLayout(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Match Opponent',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Loading(),
                  ],
                ),
              ),
            )
          : createRoomEvent.when(
              data: (data) {
                return BodyLayout(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Waiting Room',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),
                        const ChessBoard(
                          width: 300,
                          height: 300,
                        ),
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
                return const ErrorCustom(
                    errorMessage: 'unable to create room!');
              },
              loading: () => const Loading(),
            ),
    );
  }
}
