import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../entity/theme_color.dart';
import 'theme_state.dart';

extension ThemeExtension on BuildContext {
  ThemeBloc get themeCubit => read<ThemeBloc>();
  ThemeData get themeData => themeCubit.state.themeData;
  ColorScheme get colorScheme => themeData.colorScheme;
  TextTheme get textTheme => themeData.textTheme;
}

class ThemeBloc extends Cubit<ThemeState> {
  ThemeBloc()
    : super(
        ThemeState(
          themeData: _createThemeData(ThemeColor.blue, Brightness.light),
          selectedColor: ThemeColor.blue,
          brightness: Brightness.light,
        ),
      );

  void changeThemeColor(ThemeColor color) {
    final newThemeData = _createThemeData(color, state.brightness);
    emit(state.copyWith(themeData: newThemeData, selectedColor: color));
  }

  void toggleBrightness() {
    final newBrightness =
        state.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light;

    final newThemeData = _createThemeData(state.selectedColor, newBrightness);
    emit(state.copyWith(themeData: newThemeData, brightness: newBrightness));
  }

  static ThemeData _createThemeData(
    ThemeColor themeColor,
    Brightness brightness,
  ) {
    final bool isDark = brightness == Brightness.dark;

    //! Настройка цветов темы
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: themeColor.color,
      brightness: brightness,
      primary: themeColor.color,

      secondary:
          isDark
              ? themeColor.color.withOpacity(0.7)
              : themeColor.color.withOpacity(0.8),

      background: isDark ? Colors.grey[900]! : Colors.grey[50]!,

      surface: isDark ? Colors.grey[800]! : Colors.white,
      error: isDark ? Colors.red : Colors.redAccent,
    );

    //TODO короче скачать где то в интернете тему для текста и кароче чтобы тут это ее прокинуть в тему
    //TODO context.textTheme.titleLarge;
    //! настройка темы
    return ThemeData(
      // textTheme: state.themeData.textTheme.apply(),
      colorScheme: colorScheme,
      brightness: brightness,
      useMaterial3: true,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
