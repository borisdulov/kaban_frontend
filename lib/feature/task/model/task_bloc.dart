import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';
import 'package:kaban_frontend/feature/task/model/task_state.dart';

extension TaskExtension on BuildContext {
  TaskCubit get taskCubit => read<TaskCubit>();
}

typedef TaskBuilder = BlocBuilder<TaskCubit, TaskState>;

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _taskRepository;

  TaskCubit({required TaskRepository taskRepository})
    : _taskRepository = taskRepository,
      super(TaskStateLoading()) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    emit(TaskStateLoading());
    try {
      final tasks = await _taskRepository.getAllTasks();
      emit(TaskStateLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskStateFailed(error: e.toString()));
    }
  }

  Future<void> getTaskByCategoryId(String categoryId) async {
    emit(TaskStateLoading());
    try {
      final task = await _taskRepository.getTaskByCategoryId(categoryId);
      emit(TaskStateLoaded(tasks: [task], selectedTask: task));
    } catch (e) {
      emit(TaskStateFailed(error: e.toString()));
    }
  }

  Future<void> createTask(Task task) async {
    if (!state.isLoaded) return;
    final currentState = state as TaskStateLoaded;

    try {
      emit(TaskStateLoading());
      final createdTask = await _taskRepository.createTask(task);
      emit(
        currentState.copyWith(
          tasks: [...currentState.tasks, createdTask],
          selectedTask: createdTask,
        ),
      );
    } catch (e) {
      emit(TaskStateFailed(error: e.toString()));
    }
  }

  Future<void> updateTask(Task task) async {
    if (!state.isLoaded) return;
    final currentState = state as TaskStateLoaded;

    try {
      emit(TaskStateLoading());
      final updatedTask = await _taskRepository.updateTask(task);

      final updatedTasks =
          currentState.tasks.map((t) {
            return t.taskId == task.taskId ? updatedTask : t;
          }).toList();

      emit(
        currentState.copyWith(
          tasks: updatedTasks,
          selectedTask:
              currentState.selectedTask?.taskId == task.taskId
                  ? updatedTask
                  : currentState.selectedTask,
        ),
      );
    } catch (e) {
      emit(TaskStateFailed(error: e.toString()));
    }
  }

  Future<void> deleteTask(String taskId) async {
    if (!state.isLoaded) return;
    final currentState = state as TaskStateLoaded;

    try {
      emit(TaskStateLoading());
      await _taskRepository.deleteTask(taskId);

      final updatedTasks =
          currentState.tasks.where((t) => t.taskId != taskId).toList();

      emit(
        currentState.copyWith(
          tasks: updatedTasks,
          selectedTask:
              currentState.selectedTask?.taskId == taskId
                  ? null
                  : currentState.selectedTask,
        ),
      );
    } catch (e) {
      emit(TaskStateFailed(error: e.toString()));
    }
  }

  Future<void> moveTaskToCategory(String taskId, String categoryId) async {
    if (!state.isLoaded) return;
    final currentState = state as TaskStateLoaded;

    try {
      emit(TaskStateLoading());
      await _taskRepository.moveTaskToCategory(taskId, categoryId);
      final tasks = await _taskRepository.getAllTasks();
      final selectedTask = tasks.firstWhere(
        (t) => t.taskId == taskId,
        orElse: () => currentState.selectedTask!,
      );

      emit(
        TaskStateLoaded(
          tasks: tasks,
          selectedTask:
              currentState.selectedTask?.taskId == taskId
                  ? selectedTask
                  : currentState.selectedTask,
        ),
      );
    } catch (e) {
      emit(TaskStateFailed(error: e.toString()));
    }
  }

  Future<void> searchTasks() async {
    if (!state.isLoaded) return;
    try {
      emit(TaskStateLoading());
      final tasks = await _taskRepository.searchTasks();
      emit(TaskStateLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskStateFailed(error: e.toString()));
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
      emit(TaskStateLoading());
      final tasks = await _taskRepository.filterTasks(
        userIds: userIds,
        priority: priority,
        tags: tags,
        dueDate: dueDate,
        projectId: projectId,
      );
      emit(TaskStateLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskStateFailed(error: e.toString()));
    }
  }

  void selectTask(Task task) {
    if (!state.isLoaded) return;
    final currentState = state as TaskStateLoaded;

    emit(currentState.copyWith(selectedTask: task));
  }

  void clearSelectedTask() {
    if (!state.isLoaded) return;
    final currentState = state as TaskStateLoaded;

    emit(currentState.copyWith(clearSelectedTask: true));
  }
}

typedef TaskSelector<T> = BlocSelector<TaskCubit, TaskState, T>;
typedef TaskListener = BlocListener<TaskCubit, TaskState>;
