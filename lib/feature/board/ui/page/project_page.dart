import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_bloc.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_state.dart';
import 'package:kaban_frontend/feature/board/ui/widget/board_widget.dart';
import 'package:kaban_frontend/feature/board/ui/widget/app_bar_widget.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  static const String name = 'Project';
  static const String path = '/project';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardCubit, BoardState>(
      builder: (context, state) {
        return Scaffold(
          appBar:
              state.project != null
                  ? AppBarWidget(project: state.project!)
                  : AppBar(title: const Text('Загрузка')),
          body: BoardWidget(),
        );
      },
    );
  }
}
