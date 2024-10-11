import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  SettingsScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Center(
        child: SwitchListTile(
          title: Text('Modo Escuro'),
          value: isDarkMode,
          onChanged: (value) {
            toggleTheme();
          },
        ),
      ),
    );
  }
}
