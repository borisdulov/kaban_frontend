import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:kaban_frontend/core/config/bloc/config_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_state.dart';
import 'package:kaban_frontend/feature/board/data/repository/board_repository_mock_impl.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';
import 'package:kaban_frontend/feature/column/data/model/column_api_model.dart';
import 'package:kaban_frontend/feature/column/data/model/column_mock_model.dart';
import 'package:kaban_frontend/feature/column/data/repository/column_repository_mock_impl.dart';
import 'package:kaban_frontend/feature/column/domain/repository/column_repository.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/data/repository/mock/task_repository_mock.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';
import 'package:kaban_frontend/feature/user/data/model/user_mock_model.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit({
    required BoardRepository boardRepository,
    required ColumnRepository columnRepository,
    required TaskRepository taskRepository,
    required String boardId,
    required bool useMocks,
  }) : _boardRepository = boardRepository,
       _columnRepository = columnRepository,
       _taskRepository = taskRepository,
       _boardId = boardId,
       _useMocks = useMocks,
       super(const BoardState(status: Status.loading)) {
    _initMocks();
    load();
  }

  static BoardCubit from(BuildContext context, {required String boardId}) {
    final config = context.configCubit.state;
    return BoardCubit(
      boardRepository:
          config.useMocks
              ? BoardRepositoryMockImpl()
              : context.configCubit.get<BoardRepository>(),
      columnRepository:
          config.useMocks
              ? ColumnRepositoryMockImpl()
              : context.configCubit.get<ColumnRepository>(),
      taskRepository:
          config.useMocks
              ? TaskRepositoryMock()
              : context.configCubit.get<TaskRepository>(),
      boardId: boardId,
      useMocks: config.useMocks,
    );
  }

  static BlocProvider<BoardCubit> provider({required String boardId}) {
    return BlocProvider(
      create: (context) {
        final config = context.configCubit.state;

        return BoardCubit(
          boardRepository:
              config.useMocks
                  ? BoardRepositoryMockImpl()
                  : context.configCubit.get<BoardRepository>(),
          columnRepository:
              config.useMocks
                  ? ColumnRepositoryMockImpl()
                  : context.configCubit.get<ColumnRepository>(),
          taskRepository:
              config.useMocks
                  ? TaskRepositoryMock()
                  : context.configCubit.get<TaskRepository>(),
          boardId: boardId,
          useMocks: config.useMocks,
        );
      },
    );
  }

  final String _boardId;
  final BoardRepository _boardRepository;
  final ColumnRepository _columnRepository;
  final TaskRepository _taskRepository;
  final bool _useMocks;

  void _initMocks() {
    if (_useMocks) {
      if (_columnRepository is ColumnRepositoryMockImpl) {
        _columnRepository
          ..createColumn(ColumnMockModel.random())
          ..createColumn(ColumnMockModel.random());
      }
      if (_taskRepository is TaskRepositoryMock) {
        (_taskRepository).createTask(TaskMockModel.random());
      }
    }
  }

  late final AppFlowyBoardController boardController = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
      // _reorderColumns();
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
              await _taskRepository.moveTaskToColumn(item.task.id, toGroupId);
              debugPrint(
                'Задача перемещена на сервере: ${item.task.id} в колонку $toGroupId',
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
      final board = await _boardRepository.getBoardById(_boardId);
      debugPrint('Загружена доска: $board');

      final columnsData = await _columnRepository.getColumnsByBoardId(_boardId);

      debugPrint('Загружено колонок: ${columnsData.length}');

      final columns = <AppFlowyGroupData>[];

      for (final column in columnsData) {
        try {
          if (column.id.isEmpty) {
            debugPrint('Пропущена колонка с пустым ID');
            continue;
          }

          List<Task> tasks = [];
          try {
            tasks = await _taskRepository.getTasksByColumnId(column.id);
            debugPrint('Загружено задач для ${column.title}: ${tasks.length}');
          } catch (e) {
            debugPrint(
              'Ошибка при загрузке задач для колонки ${column.id}: $e',
            );
          }

          final columnData = _createColumnData(column.id, column.title, tasks);
          columns.add(columnData);
        } catch (e) {
          debugPrint('Ошибка при обработке колонки: $e');
        }
      }

      boardController.clear();
      for (final column in columns) {
        boardController.addGroup(column);
      }

      emit(BoardState(status: Status.success, columns: columns, board: board));
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
      final creator = UserMockModel.mock();

      final newTask = TaskAPIModel(
        id: '',
        title: 'Новая задача',
        description: '',
        columnId: columnId,
        userIds: [],
        creatorId: creator.id,
        creator: creator,
        priority: TaskPriority.medium,
        isCompleted: false,
      );

      debugPrint('Создание задачи для колонки: $columnId');
      debugPrint('Данные для создания задачи: ${newTask.toJSON()}');

      final createdTask = await _taskRepository.createTask(newTask);
      debugPrint('Создана новая задача на сервере: ${createdTask.id}');

      boardController
          .getGroupController(columnId)
          ?.insert(0, TaskItem(createdTask));

      final updatedColumns = List<AppFlowyGroupData>.from(state.columns);
      emit(state.copyWith(columns: updatedColumns, selectedTask: createdTask));
    } catch (e) {
      debugPrint('Ошибка при создании задачи: $e');
    }
  }

  Future<void> addNewColumn() async {
    if (!state.isLoaded) return;

    try {
      final newColumnModel = ColumnAPIModel(
        id: '',
        title: 'Новая колонка',
        boardId: _boardId,
        color: '#1976D2',
        taskIds: [],
      );

      final createdColumn = await _columnRepository.createColumn(
        newColumnModel,
      );
      debugPrint('Создана новая колонка на сервере: ${createdColumn.id}');

      final columnData = _createColumnData(
        createdColumn.id,
        createdColumn.title,
        [],
      );

      boardController.addGroup(columnData);

      final updatedColumns = List<AppFlowyGroupData>.from(state.columns)
        ..add(columnData);
      emit(state.copyWith(columns: updatedColumns));
    } catch (e) {
      debugPrint('Ошибка при создании колонки: $e');
    }
  }

  // Future<void> _reorderColumns() async {
  //   try {
  //     final columnIds = boardController.groupIds;
  //     await _columnRepository.reorderColumns(_boardId, columnIds);
  //     debugPrint('Порядок колонок обновлен на сервере');
  //   } catch (e) {
  //     debugPrint('Ошибка при обновлении порядка колонок: $e');
  //   }
  // }

  void openEditPanel(Task task) {
    emit(state.copyWith(selectedTask: task));
  }

  void closeEditPanel() {
    if (state.selectedTask != null) {
      emit(state.copyWith(selectedTask: null));
    }
  }

  void updateTask(Task updateTask) {
    if (!state.isLoaded) return;

    if (updateTask.title.isEmpty) {
      _removeTask(updateTask);
      return;
    }

    final newColomns =
        state.columns.map((column) {
          final newItems =
              column.items.map((item) {
                if (item is TaskItem && item.task.id == updateTask.id) {
                  return TaskItem(updateTask);
                }
                return item;
              }).toList();
          return AppFlowyGroupData(
            id: column.id,
            name: column.headerData.groupName,
            items: newItems,
            customData: column.customData,
          );
        }).toList();
    _updateBoardController(newColomns);
    emit(state.copyWith(columns: newColomns, selectedTask: null));
  }

  void _removeTask(Task task) {
    final newColumns =
        state.columns.map((column) {
          return AppFlowyGroupData(
            id: column.id,
            name: column.headerData.groupName,
            items:
                column.items.where((item) {
                  return !(item is TaskItem && item.task.id == task.id);
                }).toList(),
          );
        }).toList();

    _updateBoardController(newColumns);
    emit(state.copyWith(columns: newColumns, selectedTask: null));
  }

  void _updateBoardController(List<AppFlowyGroupData> newColomns) {
    boardController.clear();
    boardController.addGroups(newColomns);
  }

  @override
  Future<void> close() {
    boardController.dispose();
    return super.close();
  }
}

extension BoardExtension on BuildContext {
  BoardCubit get boardCubit => read<BoardCubit>();
}

extension ConfigExtension on BuildContext {
  void toggleMocks(bool value) {
    read<ConfigBloc>().toggleMocks(value);
  }

  ConfigBloc get configBloc => read<ConfigBloc>();
}

typedef BoardBuilder = BlocBuilder<BoardCubit, BoardState>;
typedef BoardSelector<T> = BlocSelector<BoardCubit, BoardState, T>;
typedef BoardListener = BlocListener<BoardCubit, BoardState>;
