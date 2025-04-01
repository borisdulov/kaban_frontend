import 'package:appflowy_board/appflowy_board.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/board/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

class BoardState {
  final Status status;
  final List<AppFlowyGroupData> columns;
  final Project? project;
  final String? error;

  const BoardState({
    this.status = Status.initial,
    this.columns = const [],
    this.project,
    this.error,
  });

  BoardState copyWith({
    Status? status,
    List<AppFlowyGroupData>? columns,
    Project? project,
    String? error,
  }) {
    return BoardState(
      status: status ?? this.status,
      columns: columns ?? this.columns,
      project: project ?? this.project,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == Status.loading;
  bool get isLoaded => status == Status.success;
  bool get isFailed => status == Status.failure;
}

class TaskItem extends AppFlowyGroupItem {
  final Task task;

  TaskItem(this.task);

  @override
  String get id => task.taskId;
}
