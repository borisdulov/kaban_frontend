import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';

class TaskState {
  final Status? status;
  final List<Task> tasks;
  final String? error;

  const TaskState({
    this.status = Status.initial,
    this.tasks = const [],
    this.error,
  });

  TaskState copyWith({Status? status, List<Task>? tasks, String? error}) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == Status.loading;
  bool get isLoaded => status == Status.success;
  bool get isFailed => status == Status.failure;
}
