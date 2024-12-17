import 'package:flutter/material.dart';
import 'package:product_cart_demo/src/features/home/view/home_screen.dart';
import 'package:product_cart_demo/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Product Cart Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemData,
      darkTheme: AppTheme.darkThemeData,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
