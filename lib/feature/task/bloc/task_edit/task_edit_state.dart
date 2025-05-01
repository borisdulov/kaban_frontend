import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

class TaskEditState {
  final Task? task;
  final bool isLoading;
  final String? error;

  TaskEditState({this.task, this.isLoading = false, this.error});

  TaskEditState copyWith({Task? task, bool? isLoading, String? error}) {
    return TaskEditState(
      task: task ?? this.task,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
