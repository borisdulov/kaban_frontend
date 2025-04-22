import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

extension ThemeExtension on BuildContext {
  ThemeBloc get themeCubit => read<ThemeBloc>();
  // ThemeData get themeData => themeCubit.state.themeData;
  // ColorScheme get colorScheme => themeData.colorScheme;
  // TextTheme get textTheme => themeData.textTheme;
}

class ThemeBloc extends Cubit<ThemeState> {
  ThemeBloc() : super(const ThemeState(ThemeMode.light));

  void toggleTheme() {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeState(newMode));
  }

  static BlocProvider<ThemeBloc> provider() {
    return BlocProvider(create: (context) => ThemeBloc());
  }
}
