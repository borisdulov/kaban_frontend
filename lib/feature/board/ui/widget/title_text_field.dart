import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/board_list_bloc.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';

class TitleTextField extends StatelessWidget {
  TitleTextField({super.key, required this.board})
    : _controller = TextEditingController(text: board.title);

  final Board board;
  late final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: TextField(
        controller: _controller,
        autofocus: true,
        style: context.textTheme.bodyLarge,
        decoration: InputDecoration(
          isDense: true,
          counterText: '',
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.check,
              size: 16,
              color: context.colorScheme.onSurface,
            ),
            padding: EdgeInsets.zero,
            onPressed: () => _handleSave(context),
          ),
        ),
        onSubmitted: (_) => _handleSave(context),
      ),
    );
  }

  void _handleSave(BuildContext context) {
    if (_controller.text.trim().isNotEmpty) {
      context.read<BoardListBloc>().renameBoard(
        board.id,
        _controller.text.trim(),
      );

      context.read<BoardListBloc>().fetchBoards();
    }
  }
}
