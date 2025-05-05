import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/project_list_bloc.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/project_list_state.dart';
import 'package:kaban_frontend/feature/board/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/board/ui/widget/title_text_field.dart';

class TitleEditWidget extends StatelessWidget {
  const TitleEditWidget({super.key, required this.board});

  final Project board;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: BlocSelector<ProjectListCubit, ProjectListState, String?>(
        selector: (state) => state.editingBoardId,
        builder: (context, editingId) {
          final isEditing = editingId == board.id;
          return isEditing
              ? TitleTextField(board: board)
              : Text(
                board.name,
                style: context.textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              );
        },
      ),
    );
  }
}
