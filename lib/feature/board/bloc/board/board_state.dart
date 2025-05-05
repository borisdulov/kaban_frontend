import 'package:appflowy_board/appflowy_board.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

class BoardState {
  final Status status;
  final List<AppFlowyGroupData> columns;
  final Board? board;
  final String? error;
  final Task? selectedTask;

  const BoardState({
    this.status = Status.initial,
    this.columns = const [],
    this.board,
    this.error,
    this.selectedTask,
  });

  BoardState copyWith({
    Status? status,
    List<AppFlowyGroupData>? columns,
    Board? board,
    String? error,
    Task? selectedTask,
  }) {
    return BoardState(
      status: status ?? this.status,
      columns: columns ?? this.columns,
      board: board ?? this.board,
      error: error ?? this.error,
      selectedTask: selectedTask,
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
  String get id => task.id;
}
