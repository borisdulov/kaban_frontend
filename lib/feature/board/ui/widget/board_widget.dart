import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/core/theme/data/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_bloc.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_state.dart';

import 'package:kaban_frontend/feature/board/ui/widget/add_column_button.dart';
import 'package:kaban_frontend/feature/board/ui/widget/column_board_header.dart';
import 'package:kaban_frontend/feature/task/ui/page/task_edit_page.dart';
import 'package:kaban_frontend/feature/task/ui/widget/task_widget.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardCubit, BoardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isFailed) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return Stack(
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: AppFlowyBoard(
                  controller: context.boardCubit.boardController,
                  boardScrollController:
                      context.boardCubit.boardScrollController,
                  cardBuilder: (context, group, groupItem) {
                    if (groupItem is TaskItem) {
                      return TaskWidget(
                        task: groupItem.task,
                        key: ValueKey(groupItem.id),
                      );
                    }
                    return Text('Error: groupItem is not TaskItem');
                  },
                  headerBuilder: (context, columnData) {
                    return ColumnBoardHeader(
                      key: ValueKey(columnData.id),
                      onTaskCreate:
                          () => context.boardCubit.addNewTask(
                            columnData.id,
                          ),
                      title: columnData.headerData.groupName,
                      onMenuPressed: () {},
                    );
                  },
                  config: AppFlowyBoardConfig(
                    stretchGroupHeight: false,
                    groupBackgroundColor:
                        context.colorScheme.surfaceContainerLow,
                    groupMargin: EdgeInsets.all(AppThemeSize.p12),
                    groupCornerRadius: AppRadius.r16,
                    cardMargin: EdgeInsets.zero,
                  ),
                  groupConstraints: BoxConstraints.tightFor(width: 300),
                  trailing: Padding(
                    padding: EdgeInsets.only(
                      top: AppSize.p8,
                      left: AppThemeSize.p16,
                      right: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: AddColumnButton(
                      onPressed:
                          () => context.boardCubit.addNewColumn(),
                    ),
                  ),
                ),
              ),
            ),

            if (state.selectedTask != null)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 360,
                    child: TaskEditPage(task: state.selectedTask!),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
