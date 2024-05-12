import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thai_chess_mobile/models/piece.dart';
import 'package:thai_chess_mobile/models/room.dart';
import 'package:thai_chess_mobile/providers/room_provider.dart';
import 'package:thai_chess_mobile/widgets/body_outline.dart';
import 'package:thai_chess_mobile/widgets/button_primary.dart';
import 'package:thai_chess_mobile/widgets/game_board.dart';

class GamePage extends ConsumerStatefulWidget {
  static String route = 'game';
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    int _seconds = 0;

    return Scaffold(
        body: BodyLayout(
            child: Center(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade800, Colors.blue.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/50'),
                      ),
                      const SizedBox(width: 16),
                      Text('Player 1',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: _seconds / 60,
                        strokeWidth: 8,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blue.shade200),
                        backgroundColor: Colors.grey[800],
                      ),
                    ),
                    Text(
                      '${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            GameBoard(height: height),
            ButtonPrimary(onClick: () {}, label: 'Surrender')
          ],
        ),
      ),
    )));
  }
}
