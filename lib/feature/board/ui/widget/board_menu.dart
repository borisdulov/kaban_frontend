import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/project_list_bloc.dart';
import 'package:kaban_frontend/feature/board/domain/entity/project_entity.dart';

class BoardMenu extends StatelessWidget {
  const BoardMenu({super.key, required this.board});

  final Project board;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        size: 16,
        color: context.colorScheme.onSurface,
      ),
      itemBuilder:
          (context) => [
            const PopupMenuItem(value: 'rename', child: Text('Rename')),
          ],
      onSelected: (value) {
        if (value == 'rename') {
          context.read<ProjectListCubit>().startEditing(board.id);
        }
      },
    );
  }
}
