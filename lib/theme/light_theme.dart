import 'package:flutter/material.dart';

class LightTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      headlineMedium: TextStyle(fontSize: 22, color: Colors.black87),
      headlineSmall: TextStyle(fontSize: 20, color: Colors.black54),
      titleLarge: TextStyle(fontSize: 18, color: Colors.black54),
      titleMedium: TextStyle(fontSize: 16, color: Colors.black54),
      titleSmall: TextStyle(fontSize: 14, color: Colors.black38),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.orange,
      background: Colors.white,
      surface: Colors.grey,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
  );
}
