import 'package:flutter/material.dart';

class ThemeDataProvider {
  static const List<Color> primaryColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.indigo,
  ];

  static ThemeData getTheme(Color color) {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
      ),
    );
  }
}

