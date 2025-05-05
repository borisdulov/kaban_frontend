import 'package:kaban_frontend/feature/board/domain/entity/project_entity.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';

class ProjectListState {
  final Status? status;
  final List<Project> boards;
  final String? error;
  final String? editingBoardId;

  const ProjectListState({
    this.status = Status.initial,
    this.boards = const [],
    this.error,
    this.editingBoardId,
  });

  ProjectListState copyWith({
    Status? status,
    List<Project>? projects,
    String? error,
    String? editingBoardId,
  }) {
    return ProjectListState(
      status: status ?? this.status,
      boards: projects ?? boards,
      error: error ?? this.error,
      editingBoardId: editingBoardId ?? this.editingBoardId,
    );
  }

  bool get isLoading => status == Status.loading;
  bool get isLoaded => status == Status.success;
  bool get isFailed => status == Status.failure;
}
