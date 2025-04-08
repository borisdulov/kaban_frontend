import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:kaban_frontend/core/config/bloc/config_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_state.dart';
import 'package:kaban_frontend/feature/board/domain/repository/project_repository.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit({
    required ProjectRepository projectRepository,
    required String projectId,
  }) : _projectRepository = projectRepository,
       _projectId = projectId,
       super(const BoardState(status: Status.loading)) {
    load();
  }

  final String _projectId;
  final ProjectRepository _projectRepository;
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

  final AppFlowyBoardScrollController boardScrollController =
      AppFlowyBoardScrollController();

  Future<void> load() async {
    emit(state.copyWith(status: Status.loading));

    try {
      // final project = await _projectRepository.getProjectById(_projectId);
      final project = await _projectRepository.getProjectById(
        "67f4f5485bae78af6594668c",
      );
      debugPrint('Загружена доска: $project');

      final columns =
          // project.columns?.map((category) {
          //   return _createColumnData(
          //     category.id,
          //     category.name,
          //     category.tasks ?? [],
          //   );
          // }).toList() ??
          [];

      boardController.clear();
      for (final column in columns) {
        boardController.addGroup(column);
      }

      emit(BoardState(status: Status.success, columns: [], project: project));
    } catch (e) {
      debugPrint('Ошибка загрузки доски: $e');
      emit(BoardState(status: Status.failure, error: e.toString()));
    }
  }

  AppFlowyGroupData _createColumnData(
    String id,
    String name,
    List<Task> tasks,
  ) {
    return AppFlowyGroupData(
      id: id,
      name: name,
      items: List<AppFlowyGroupItem>.from(
        tasks.map((task) => TaskItem(task)).toList(),
      ),
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

    final newColumnId = 'new-column-${Random().nextInt(1000)}';
    final newColumn = _createColumnData(newColumnId, 'Новая колонка', []);

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

  static BlocProvider<BoardCubit> provider({required String projectId}) {
    return BlocProvider(
      create:
          (context) => BoardCubit(
            projectRepository: context.configCubit.get<ProjectRepository>(),
            projectId: projectId,
          ),
    );
  }
}

extension BoardExtension on BuildContext {
  BoardCubit get boardCubit => read<BoardCubit>();
}

typedef BoardBuilder = BlocBuilder<BoardCubit, BoardState>;
typedef BoardSelector<T> = BlocSelector<BoardCubit, BoardState, T>;
typedef BoardListener = BlocListener<BoardCubit, BoardState>;
