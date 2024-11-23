import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créditos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Igor',
                  style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge?.color),
                ),
                SizedBox(height: 10),
                Text(
                  'João Henrique Lima',
                  style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge?.color),
                ),
                SizedBox(height: 10),
                Text(
                  'Julia Amorim',
                  style: TextStyle(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge?.color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
