import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/theme/domain/cubit/theme_cubit.dart';
import 'package:kaban_frontend/core/theme/domain/entity/theme_color.dart';
import 'package:kaban_frontend/core/theme/domain/cubit/theme_state.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Theme Settings'),
          ),
          body: Column(
            children: [
              // Переключатель темной/светлой темы
              SwitchListTile(
                title: Text('Dark Mode'),
                value: state.brightness == Brightness.dark,
                onChanged: (bool value) {
                  context.read<ThemeCubit>().toggleBrightness();
                },
              ),
              // Выбор цвета темы
              Wrap(
                spacing: 8.0,
                children: ThemeColor.values.map((color) {
                  return InkWell(
                    onTap: () {
                      context.read<ThemeCubit>().changeThemeColor(color);
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color.color,
                        shape: BoxShape.circle,
                        border: state.selectedColor == color
                            ? Border.all(width: 2, color: Colors.white)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
