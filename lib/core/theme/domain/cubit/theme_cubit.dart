import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../entity/theme_color.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
          themeData: _createThemeData(ThemeColor.blue, Brightness.light),
          selectedColor: ThemeColor.blue,
          brightness: Brightness.light,
        ));

  void changeThemeColor(ThemeColor color) {
    final newThemeData = _createThemeData(color, state.brightness);
    emit(state.copyWith(
      themeData: newThemeData,
      selectedColor: color,
    ));
  }

  void toggleBrightness() {
    final newBrightness = state.brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;

    final newThemeData = _createThemeData(state.selectedColor, newBrightness);
    emit(state.copyWith(
      themeData: newThemeData,
      brightness: newBrightness,
    ));
  }

  static ThemeData _createThemeData(
      ThemeColor themeColor, Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    // Настраиваем оттенки цвета в зависимости от яркости
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: themeColor.color,
      brightness: brightness,
      primary: themeColor.color,
      // Настраиваем вторичные цвета
      secondary: isDark
          ? themeColor.color.withOpacity(0.7)
          : themeColor.color.withOpacity(0.8),
      // Настраиваем фон
      background: isDark ? Colors.grey[900]! : Colors.grey[50]!,
      // Настраиваем поверхности
      surface: isDark ? Colors.grey[800]! : Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      brightness: brightness,
      useMaterial3: true,
      // Настраиваем цвета AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? colorScheme.surface : colorScheme.primary,
        foregroundColor: isDark ? colorScheme.onSurface : colorScheme.onPrimary,
      ),
      // Настраиваем цвета кнопок
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
