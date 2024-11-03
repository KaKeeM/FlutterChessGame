import 'package:flutter/material.dart';
import 'screens/credits_screen.dart';
import 'screens/game_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/themes.dart';

void main() {
  runApp(ChessApp());
}

class ChessApp extends StatefulWidget {
  @override
  _ChessAppState createState() => _ChessAppState();
}

class _ChessAppState extends State<ChessApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Rota inicial
      routes: {
        '/': (context) => HomeScreen(isDarkMode: false), // Rota inicial para HomeScreen
        '/home': (context) => HomeScreen(isDarkMode: false), // Rota para HomeScreen
        '/game': (context) => GameScreen(), // Rota para GameScreen
        '/credits': (context) => CreditsScreen(), // Rota para CreditsScreen
      },
    );
  }
}
