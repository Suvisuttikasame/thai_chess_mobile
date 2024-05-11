import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thai_chess_mobile/widgets/body_outline.dart';
import 'package:thai_chess_mobile/widgets/button_primary.dart';

class GamePage extends StatefulWidget {
  static String route = 'game';
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
                        offset: Offset(0, 3),
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
            SizedBox(
              width: double.infinity,
              height: height * 0.6,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemCount: 64,
                itemBuilder: (BuildContext context, int index) {
                  bool isWhite = (index + ((index / 8).floor())) % 2 == 0;
                  return Container(
                    decoration: BoxDecoration(
                      color: isWhite ? Colors.white : Colors.grey.shade700,
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          isWhite ? Colors.white : Colors.grey.shade700,
                          isWhite
                              ? Colors.white.withOpacity(0.7)
                              : Colors.grey.shade600,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ButtonPrimary(onClick: () {}, label: 'Surrender')
          ],
        ),
      ),
    )));
  }
}
