import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/theme/domain/cubit/theme_bloc.dart';
import 'package:kaban_frontend/core/theme/domain/cubit/theme_state.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => context.read<ThemeBloc>().toggleBrightness(),
          icon: Icon(
            state.brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
        );
      },
    );
  }
}
