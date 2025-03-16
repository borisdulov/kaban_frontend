import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/project/bloc/board_state.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

extension BoardExtension on BuildContext {
  BoardCubit get boardCubit => read<BoardCubit>();
}

typedef BoardBuilder = BlocBuilder<BoardCubit, BoardState>;
typedef BoardSelector<T> = BlocSelector<BoardCubit, BoardState, T>;
typedef BoardListener = BlocListener<BoardCubit, BoardState>;

class BoardCubit extends Cubit<BoardState> {
  final AppFlowyBoardController boardController = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  BoardCubit() : super(const BoardState(status: Status.loading)) {
    initializeBoard();
  }

  void initializeBoard() {
    emit(state.copyWith(status: Status.loading));

    try {
      final columns = [
        _createColumnData('Backlog', [
          TaskMockModel.random(),
          TaskMockModel.random(),
          TaskMockModel.random(),
          TaskMockModel.random(),
        ]),
        _createColumnData('In Progress', [
          TaskMockModel.random(),
          TaskMockModel.random(),
        ]),
        _createColumnData('Done', [TaskMockModel.random()]),
      ];

      for (final column in columns) {
        boardController.addGroup(column);
      }

      emit(BoardState(status: Status.success, columns: columns));
    } catch (e) {
      emit(BoardState(status: Status.failure, error: e.toString()));
    }
  }

  AppFlowyGroupData _createColumnData(String name, List<Task> tasks) {
    return AppFlowyGroupData(
      id: name + Random().nextInt(300).toString(),
      name: name,
      items: List<AppFlowyGroupItem>.from(tasks.map((e) => TaskItem(e))),
    );
  }

  void addNewTask(String columnId) {
    if (!state.isLoaded) return;

    final newTask = TaskMockModel.random();
    boardController.getGroupController(columnId)?.insert(0, TaskItem(newTask));

    final updatedColumns = List<AppFlowyGroupData>.from(state.columns);
    emit(state.copyWith(columns: updatedColumns));
  }

  void addNewColumn() {
    if (!state.isLoaded) return;

    final newColumn = _createColumnData('Новая колонка', []);
    boardController.addGroup(newColumn);

    final updatedColumns = List<AppFlowyGroupData>.from(state.columns)
      ..add(newColumn);
    emit(state.copyWith(columns: updatedColumns));
  }

  @override
  Future<void> close() {
    boardController.dispose();
    return super.close();
  }
}
