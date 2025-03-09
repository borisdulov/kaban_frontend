import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

abstract interface class TaskState {
  bool get isLoading => this is TaskStateLoading;
  bool get isLoaded => this is TaskStateLoaded;
  bool get isFailed => this is TaskStateFailed;
}

class TaskStateLoading extends TaskState {}

class TaskStateFailed extends TaskState {
  final String error;

  TaskStateFailed({required this.error});
}

class TaskStateLoaded extends TaskState {
  final List<Task> tasks;
  final Task? selectedTask;

  TaskStateLoaded({required this.tasks, this.selectedTask});

  TaskStateLoaded copyWith({
    List<Task>? tasks,
    Task? selectedTask,
    bool clearSelectedTask = false,
  }) {
    return TaskStateLoaded(
      tasks: tasks ?? this.tasks,
      selectedTask:
          clearSelectedTask ? null : selectedTask ?? this.selectedTask,
    );
  }
}
