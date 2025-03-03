import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/theme/domain/cubit/theme_cubit.dart';
import 'package:kaban_frontend/feature/theme/domain/state/theme_state.dart';
import 'package:kaban_frontend/feature/theme/presentation/theme_change_button.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: state.themeData,
          home: ThemeSettingsPage(),
        );
      },
    );
  }
}