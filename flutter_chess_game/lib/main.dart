import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
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
      theme: isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme,
      home: HomeScreen(
        onThemeChanged: toggleTheme,
        isDarkMode: isDarkMode,
      ),
    );
  }
}
