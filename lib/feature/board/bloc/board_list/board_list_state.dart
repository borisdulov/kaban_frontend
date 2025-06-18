import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';

class BoardListState {
  final Status? status;
  final List<Board> boards;
  final String? error;
  final String? editingBoardId;

  const BoardListState({
    this.status = Status.initial,
    this.boards = const [],
    this.error,
    this.editingBoardId,
  });

  BoardListState copyWith({
    Status? status,
    List<Board>? boards,
    String? error,
    String? editingBoardId,
  }) {
    return BoardListState(
      status: status ?? this.status,
      boards: boards ?? this.boards,
      error: error ?? this.error,
      editingBoardId: editingBoardId ?? this.editingBoardId,
    );
  }

  bool get isLoading => status == Status.loading;
  bool get isLoaded => status == Status.success;
  bool get isFailed => status == Status.failure;
}
