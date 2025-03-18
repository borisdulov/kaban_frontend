import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/feature/project/bloc/board_bloc.dart';
import 'package:kaban_frontend/feature/project/bloc/board_state.dart';
import 'package:kaban_frontend/feature/project/data/repository/project_repository_mock_impl.dart';
import 'package:kaban_frontend/feature/project/ui/widget/add_column_button.dart';
import 'package:kaban_frontend/feature/project/ui/widget/column_board_header.dart';
import 'package:kaban_frontend/feature/task/ui/widget/task_widget.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              BoardCubit(projectRepository: ProjectRepositoryMockImpl()),
      child: BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isFailed) {
            return Center(child: Text('Error: ${state.error}'));
          }

          final boardCubit = context.read<BoardCubit>();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppFlowyBoard(
                  controller: boardCubit.boardController,
                  boardScrollController: boardCubit.boardScrollController,
                  cardBuilder: (context, group, groupItem) {
                    if (groupItem is TaskItem) {
                      return TaskWidget(
                        task: groupItem.task,
                        key: ValueKey(groupItem.id),
                      );
                    }
                    return Text(
                      'Error: groupItem is not TaskItem',
                      key: ValueKey(groupItem.id),
                    );
                  },
                  headerBuilder: (context, columnData) {
                    return ColumnBoardHeader(
                      key: ValueKey(columnData.id),
                      onTaskCreate: () => boardCubit.addNewTask(columnData.id),
                      onMenuPressed: () {},
                      title: columnData.headerData.groupName,
                    );
                  },
                  config: AppFlowyBoardConfig(
                    stretchGroupHeight: false,
                    groupBackgroundColor: Color.fromRGBO(248, 246, 245, 1),
                    groupMargin: EdgeInsets.all(AppThemeSize.p12),
                    groupCornerRadius: AppRadius.r16,
                    cardMargin: EdgeInsets.all(0),
                  ),
                  groupConstraints: BoxConstraints.tightFor(width: 300),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppThemeSize.p8,
                      horizontal: AppThemeSize.p16,
                    ),
                    decoration: BoxDecoration(),
                    child: AddColumnButton(
                      onPressed: () => boardCubit.addNewColumn(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
