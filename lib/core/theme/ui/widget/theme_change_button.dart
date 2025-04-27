import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/theme/cubit/theme_bloc.dart';
import 'package:kaban_frontend/core/theme/cubit/theme_state.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.read<ThemeBloc>().toggleTheme(),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: state.themeMode == ThemeMode.dark
                ? const Icon(
                    Icons.nightlight_round,
                    key: ValueKey('moon'),
                    size: 24,
                  )
                : const Icon(
                    Icons.wb_sunny,
                    key: ValueKey('sun'),
                    size: 24,
                  ),
          ),
        );
      },
    );
  }
}