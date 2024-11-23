import 'package:flutter/material.dart';
import 'screens/credits_screen.dart';
import 'screens/login_screen.dart';
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
      theme: AppThemes.lightTheme, // Tema claro
      darkTheme: AppThemes.darkTheme, // Tema escuro
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light, // Alterna o tema
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(isDarkMode: isDarkMode),
        '/game': (context) => GameScreen(),
        '/credits': (context) => CreditsScreen(),
        '/settings': (context) => SettingsScreen(
              toggleTheme: toggleTheme,
              isDarkMode: isDarkMode,
            ),
      },
    );
  }
}
