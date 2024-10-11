import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightText),
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light, 
      primarySwatch: Colors.blue, 
    ).copyWith(
      secondary: AppColors.lightPrimary,
      background: AppColors.lightBackground,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText),
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.grey,
    ).copyWith(
      secondary: AppColors.darkPrimary,
      background: AppColors.darkBackground,
    ),
  );
}
