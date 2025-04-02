import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ThemeState && other.themeMode == themeMode);
  }

  @override
  int get hashCode => themeMode.hashCode;
}
