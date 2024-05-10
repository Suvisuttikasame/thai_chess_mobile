import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:thai_chess_mobile/pages/finding_opponent_page.dart';
import 'package:thai_chess_mobile/widgets/app_bar.dart';
import 'package:thai_chess_mobile/widgets/button_primary.dart';
import 'package:thai_chess_mobile/widgets/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String route = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  void _onClick() {
    Navigator.pushNamed(context, WaitingRoomPage.route);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const Menu(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.onPrimary,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: (_animation.value * 1) - 0.4,
                    child: WhiteKnight(
                      size: 200,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ButtonPrimary(
                onClick: _onClick,
                label: 'Play',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
