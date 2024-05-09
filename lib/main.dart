import 'package:flutter/material.dart';
import 'package:thai_chess_mobile/pages/finding_opponent_page.dart';
import 'package:thai_chess_mobile/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess Pro',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          onPrimary: Colors.deepPurple.shade800,
          primary: Colors.deepPurple.shade200,
          onSecondary: Colors.deepPurple.shade900,
          secondary: Colors.deepPurple.shade600,
        ),
        textTheme: const TextTheme().copyWith(
            titleLarge: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            titleMedium: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyMedium: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            )),
      ),
      routes: {
        HomePage.route: (context) => const HomePage(),
        WaitingRoomPage.route: (context) => const WaitingRoomPage(),
      },
      initialRoute: HomePage.route,
      home: const HomePage(),
    );
  }
}
