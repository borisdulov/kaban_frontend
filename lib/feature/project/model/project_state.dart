import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';

abstract interface class ProjectState {
  bool get isLoading => this is ProjectStateLoading;
  bool get isLoaded => this is ProjectStateLoaded;
  bool get isFailed => this is ProjectStateFailed;
}

class ProjectStateLoading extends ProjectState {}

class ProjectStateFailed extends ProjectState {
  final String error;

  ProjectStateFailed({required this.error});
}

class ProjectStateLoaded extends ProjectState {
  final List<Project> projects;
  final Project? selectedProject;

  ProjectStateLoaded({
    required this.projects,
    this.selectedProject,
  });

  ProjectStateLoaded copyWith({
    List<Project>? projects,
    Project? selectedProject,
    bool clearSelectedProject = false,
  }) {
    return ProjectStateLoaded(
      projects: projects ?? this.projects,
      selectedProject: clearSelectedProject ? null : selectedProject ?? this.selectedProject,
    );
  }
} 