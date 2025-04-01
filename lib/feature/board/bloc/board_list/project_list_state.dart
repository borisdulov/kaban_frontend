import 'package:kaban_frontend/feature/board/domain/entity/project_entity.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';

class ProjectListState {
  final Status? status;
  final List<Project> projects;
  final String? error;

  const ProjectListState({
    this.status = Status.initial,
    this.projects = const [],
    this.error,
  });

  ProjectListState copyWith({
    Status? status,
    List<Project>? projects,
    String? error,
  }) {
    return ProjectListState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == Status.loading;
  bool get isLoaded => status == Status.success;
  bool get isFailed => status == Status.failure;
}
