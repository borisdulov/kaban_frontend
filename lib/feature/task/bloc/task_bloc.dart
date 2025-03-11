import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';
import 'package:kaban_frontend/feature/task/bloc/task_state.dart';

extension TaskExtension on BuildContext {
  TaskCubit get taskCubit => read<TaskCubit>();
}

typedef TaskBuilder = BlocBuilder<TaskCubit, TaskState>;

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _taskRepository;

  TaskCubit({required TaskRepository taskRepository})
    : _taskRepository = taskRepository,
      super(const TaskState(status: Status.loading)) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final tasks = await _taskRepository.getAllTasks();
      emit(TaskState(status: Status.success, tasks: tasks));
    } catch (e) {
      emit(TaskState(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> getTaskByCategoryId(String categoryId) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final task = await _taskRepository.getTaskByCategoryId(categoryId);
      emit(TaskState(status: Status.success, tasks: [task]));
    } catch (e) {
      emit(TaskState(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> createTask(Task task) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final createdTask = await _taskRepository.createTask(task);
      emit(
        state.copyWith(
          status: Status.success,
          tasks: [...state.tasks, createdTask],
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> updateTask(Task task) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final updatedTask = await _taskRepository.updateTask(task);

      final updatedTasks =
          state.tasks.map((t) {
            return t.taskId == task.taskId ? updatedTask : t;
          }).toList();

      emit(state.copyWith(status: Status.success, tasks: updatedTasks));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> deleteTask(String taskId) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      await _taskRepository.deleteTask(taskId);

      final updatedTasks =
          state.tasks.where((t) => t.taskId != taskId).toList();

      emit(state.copyWith(status: Status.success, tasks: updatedTasks));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> moveTaskToCategory(String taskId, String categoryId) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      await _taskRepository.moveTaskToCategory(taskId, categoryId);
      final tasks = await _taskRepository.getAllTasks();

      emit(state.copyWith(status: Status.success, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> searchTasks() async {
    if (!state.isLoaded) return;
    try {
      emit(state.copyWith(status: Status.loading));
      final tasks = await _taskRepository.searchTasks();
      emit(state.copyWith(status: Status.success, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> filterTasks({
    List<String>? userIds,
    TaskPriority? priority,
    List<String>? tags,
    DateTime? dueDate,
    String? projectId,
  }) async {
    if (!state.isLoaded) return;
    try {
      emit(state.copyWith(status: Status.loading));
      final tasks = await _taskRepository.filterTasks(
        userIds: userIds,
        priority: priority,
        tags: tags,
        dueDate: dueDate,
        projectId: projectId,
      );
      emit(state.copyWith(status: Status.success, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}

typedef TaskSelector<T> = BlocSelector<TaskCubit, TaskState, T>;
typedef TaskListener = BlocListener<TaskCubit, TaskState>;
