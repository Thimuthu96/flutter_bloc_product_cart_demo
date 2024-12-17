import 'package:flutter/material.dart';

class DarkTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: const Color(0xff121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(fontSize: 16, color: Colors.white70),
      headlineSmall: TextStyle(fontSize: 14, color: Colors.white60),
      titleLarge: TextStyle(fontSize: 14, color: Colors.white60),
      titleMedium: TextStyle(fontSize: 12, color: Colors.white60),
      titleSmall: TextStyle(fontSize: 12, color: Colors.white54),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.teal,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.teal,
      secondary: Colors.amber,
      background: Color(0xff121212),
      surface: Colors.grey,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
  );
}
