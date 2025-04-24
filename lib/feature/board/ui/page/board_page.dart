import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_bloc.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_state.dart';
import 'package:kaban_frontend/feature/board/ui/widget/board_widget.dart';
import 'package:kaban_frontend/feature/board/ui/widget/app_bar_widget.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({super.key, required this.boardId});

  final String boardId;

  static const String name = 'Board';
  static const String path = '/board/';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardCubit, BoardState>(
      builder: (context, state) {
        return Scaffold(
          appBar:
              state.board != null
                  ? AppBarWidget(board: state.board!)
                  : AppBar(title: Text('Доска $boardId')),
          body: BoardWidget(),
        );
      },
    );
  }
}
