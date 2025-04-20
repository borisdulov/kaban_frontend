import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:kaban_frontend/core/config/bloc/config_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_state.dart';
import 'package:kaban_frontend/feature/board/domain/repository/project_repository.dart';
import 'package:kaban_frontend/feature/category/data/model/category_api_model.dart';
import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart';
import 'package:kaban_frontend/feature/category/domain/repository/category_repository.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit({
    required ProjectRepository projectRepository,
    required CategoryRepository categoryRepository,
    required TaskRepository taskRepository,
    required String projectId,
  }) : _projectRepository = projectRepository,
       _categoryRepository = categoryRepository,
       _taskRepository = taskRepository,
       _projectId = projectId,
       super(const BoardState(status: Status.loading)) {
    load();
  }

  final String _projectId;
  final ProjectRepository _projectRepository;
  final CategoryRepository _categoryRepository;
  final TaskRepository _taskRepository;

  late final AppFlowyBoardController boardController = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
      _reorderCategories();
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) async {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
      final groupController = boardController.getGroupController(fromGroupId);
      if (groupController != null) {
        final items = groupController.items;
        if (fromIndex < items.length) {
          final item = items[fromIndex];
          if (item is TaskItem) {
            try {
              await _taskRepository.moveTaskToCategory(
                item.task.taskId,
                toGroupId,
              );
              debugPrint(
                'Задача перемещена на сервере: ${item.task.taskId} в колонку $toGroupId',
              );
            } catch (e) {
              debugPrint('Ошибка при перемещении задачи: $e');
            }
          }
        }
      }
    },
  );

  final AppFlowyBoardScrollController boardScrollController =
      AppFlowyBoardScrollController();

  Future<void> load() async {
    emit(state.copyWith(status: Status.loading));

    try {
      final project = await _projectRepository.getProjectById(_projectId);
      debugPrint('Загружена доска: $project');

      final categories = await _categoryRepository.getCategoriesByProjectId(
        _projectId,
      );

      debugPrint('Загружено категорий: ${categories.length}');

      final columns = <AppFlowyGroupData>[];

      for (final category in categories) {
        try {
          if (category.id.isEmpty) {
            debugPrint('Пропущена колонка с пустым ID');
            continue;
          }

          List<Task> tasks = [];
          try {
            tasks = await _categoryRepository.getTasksByCategoryId(category.id);
            debugPrint('Загружено задач для ${category.name}: ${tasks.length}');
          } catch (e) {
            debugPrint(
              'Ошибка при загрузке задач для колонки ${category.id}: $e',
            );
          }

          final columnData = _createColumnData(
            category.id,
            category.name,
            tasks,
          );
          columns.add(columnData);
        } catch (e) {
          debugPrint('Ошибка при обработке колонки: $e');
        }
      }

      boardController.clear();
      for (final column in columns) {
        boardController.addGroup(column);
      }

      emit(
        BoardState(status: Status.success, columns: columns, project: project),
      );
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

  Future<void> addNewTask(String columnId) async {
    if (!state.isLoaded) return;

    try {
      final newTask = TaskAPIModel(
        taskId: '',
        title: 'Новая задача',
        description: '',
        categoryId: columnId,
        isCompleted: false,
        priority: TaskPriority.medium,
        createdAt: DateTime.now(),
      );

      debugPrint('Создание задачи для колонки: $columnId');
      debugPrint('Данные для создания задачи: ${newTask.toJSON()}');

      final createdTask = await _taskRepository.createTask(newTask);
      debugPrint('Создана новая задача на сервере: ${createdTask.taskId}');

      boardController
          .getGroupController(columnId)
          ?.insert(0, TaskItem(createdTask));

      final updatedColumns = List<AppFlowyGroupData>.from(state.columns);
      emit(state.copyWith(columns: updatedColumns));
    } catch (e) {
      debugPrint('Ошибка при создании задачи: $e');
    }
  }

  Future<void> addNewColumn() async {
    if (!state.isLoaded) return;

    try {
      final newCategory = CategoryAPIModel(
        id: '',
        name: 'Новая колонка',
        projectId: _projectId,
        color: Colors.blue,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        position: state.columns.length,
        taskIds: [],
      );

      final createdCategory = await _categoryRepository.createCategory(
        newCategory,
      );
      debugPrint('Создана новая колонка на сервере: ${createdCategory.id}');

      final newColumn = _createColumnData(
        createdCategory.id,
        createdCategory.name,
        [],
      );

      boardController.addGroup(newColumn);

      final updatedColumns = List<AppFlowyGroupData>.from(state.columns)
        ..add(newColumn);
      emit(state.copyWith(columns: updatedColumns));
    } catch (e) {
      debugPrint('Ошибка при создании колонки: $e');
    }
  }

  Future<void> _reorderCategories() async {
    try {
      final categoryIds = boardController.groupIds;
      await _categoryRepository.reorderCategories(_projectId, categoryIds);
      debugPrint('Порядок колонок обновлен на сервере');
    } catch (e) {
      debugPrint('Ошибка при обновлении порядка колонок: $e');
    }
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
            categoryRepository: context.configCubit.get<CategoryRepository>(),
            taskRepository: context.configCubit.get<TaskRepository>(),
            projectId: "6805780ee522fad62a18def0",
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
