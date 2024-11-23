import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'settings_screen.dart';
import 'credits_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;

  HomeScreen({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chess Game'),
        backgroundColor: Theme.of(context).primaryColor, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game');
              },
              child: Text('Jogar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: Text('Configurações'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/credits');
              },
              child: Text('Créditos'),
            ),
          ],
        ),
      ),
    );
  }
}
