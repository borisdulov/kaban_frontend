import 'package:flutter/material.dart';
import '../entity/theme_color.dart';

class ThemeState {
  final ThemeData themeData;
  final ThemeColor selectedColor;
  final Brightness brightness;

  ThemeState({
    required this.themeData,
    required this.selectedColor,
    required this.brightness,
  });

  ThemeState copyWith({
    ThemeData? themeData,
    ThemeColor? selectedColor,
    Brightness? brightness,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      selectedColor: selectedColor ?? this.selectedColor,
      brightness: brightness ?? this.brightness,
    );
  }
}