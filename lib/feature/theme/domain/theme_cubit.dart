import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/theme/data/theme_provider.dart';

class ThemeCubit extends Cubit<Color> {
  ThemeCubit() : super(ThemeDataProvider.primaryColors[0]);

  void changeTheme(Color color) {
    emit(color);
  }

  ThemeData getCurrentTheme() {
    return ThemeDataProvider.getTheme(state);
  }
}