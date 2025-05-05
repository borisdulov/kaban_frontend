import 'package:flutter/material.dart';

enum ThemeColor {
  red(Colors.red),
  green(Colors.green),
  blue(Colors.blue),
  yellow(Colors.yellow),
  purple(Colors.purple),
  orange(Colors.orange),
  teal(Colors.teal),
  indigo(Colors.indigo);

  final Color color;
  const ThemeColor(this.color);
}
