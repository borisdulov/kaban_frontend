import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/theme/data/theme_provider.dart';
import '../domain/theme_cubit.dart';
//
class ThemeChangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.color_lens),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Выберите цвет темы"),
              content: SingleChildScrollView(
                child: Column(
                  children: ThemeDataProvider.primaryColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<ThemeCubit>(context).changeTheme(color);
                        Navigator.of(context).pop();
                        context.read<ThemeCubit>().changeTheme(color);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Padding(
                          padding: EdgeInsets.all(10)),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle
                        )
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}