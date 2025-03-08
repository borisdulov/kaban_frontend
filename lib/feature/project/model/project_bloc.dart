import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/project/domain/repository/project_repository.dart';
import 'package:kaban_frontend/feature/project/model/project_state.dart';

extension ProjectExtension on BuildContext {
  ProjectCubit get projectCubit => read<ProjectCubit>();
}

typedef ProjectBuilder = BlocBuilder<ProjectCubit, ProjectState>;

class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepository _projectRepository;

  ProjectCubit({required ProjectRepository projectRepository})
    : _projectRepository = projectRepository,
      super(ProjectStateLoading()) {
    fetchProjects();
  }

  static ProjectCubit i(BuildContext context) => context.read<ProjectCubit>();

  Future<void> fetchProjects() async {
    emit(ProjectStateLoading());
    try {
      final projects = await _projectRepository.getAllProjects();
      emit(ProjectStateLoaded(projects: projects));
    } catch (e) {
      emit(ProjectStateFailed(error: e.toString()));
    }
  }

  Future<void> fetchProjectById(String id) async {
    if (!state.isLoaded) return;
    final currentState = state as ProjectStateLoaded;

    try {
      emit(ProjectStateLoading());
      final project = await _projectRepository.getProjectById(id);
      emit(
        ProjectStateLoaded(
          projects: currentState.projects,
          selectedProject: project,
        ),
      );
    } catch (e) {
      emit(ProjectStateFailed(error: e.toString()));
    }
  }

  Future<void> createProject(Project project) async {
    if (!state.isLoaded) return;
    final currentState = state as ProjectStateLoaded;

    try {
      emit(ProjectStateLoading());
      final createdProject = await _projectRepository.createProject(project);
      emit(
        ProjectStateLoaded(
          projects: [...currentState.projects, createdProject],
          selectedProject: currentState.selectedProject,
        ),
      );
    } catch (e) {
      emit(ProjectStateFailed(error: e.toString()));
    }
  }

  Future<void> updateProject(String id, Project project) async {
    if (!state.isLoaded) return;
    final currentState = state as ProjectStateLoaded;

    try {
      emit(ProjectStateLoading());
      final updatedProject = await _projectRepository.updateProject(
        id,
        project,
      );

      final updatedProjects =
          currentState.projects.map((p) {
            return p.id == id ? updatedProject : p;
          }).toList();

      emit(
        ProjectStateLoaded(
          projects: updatedProjects,
          selectedProject:
              currentState.selectedProject?.id == id
                  ? updatedProject
                  : currentState.selectedProject,
        ),
      );
    } catch (e) {
      emit(ProjectStateFailed(error: e.toString()));
    }
  }

  Future<void> deleteProject(String id) async {
    if (!state.isLoaded) return;
    final currentState = state as ProjectStateLoaded;

    try {
      emit(ProjectStateLoading());
      await _projectRepository.deleteProject(id);

      final updatedProjects =
          currentState.projects.where((p) => p.id != id).toList();

      emit(
        ProjectStateLoaded(
          projects: updatedProjects,
          selectedProject:
              currentState.selectedProject?.id == id
                  ? null
                  : currentState.selectedProject,
        ),
      );
    } catch (e) {
      emit(ProjectStateFailed(error: e.toString()));
    }
  }

  Future<void> addMember(String projectId, String userId) async {
    if (!state.isLoaded) return;
    final currentState = state as ProjectStateLoaded;

    try {
      emit(ProjectStateLoading());
      final updatedProject = await _projectRepository.addMember(
        projectId,
        userId,
      );

      final updatedProjects =
          currentState.projects.map((p) {
            return p.id == projectId ? updatedProject : p;
          }).toList();

      emit(
        ProjectStateLoaded(
          projects: updatedProjects,
          selectedProject:
              currentState.selectedProject?.id == projectId
                  ? updatedProject
                  : currentState.selectedProject,
        ),
      );
    } catch (e) {
      emit(ProjectStateFailed(error: e.toString()));
    }
  }

  Future<void> removeMember(String projectId, String userId) async {
    if (!state.isLoaded) return;
    final currentState = state as ProjectStateLoaded;

    try {
      emit(ProjectStateLoading());
      final updatedProject = await _projectRepository.removeMember(
        projectId,
        userId,
      );

      final updatedProjects =
          currentState.projects.map((p) {
            return p.id == projectId ? updatedProject : p;
          }).toList();

      emit(
        ProjectStateLoaded(
          projects: updatedProjects,
          selectedProject:
              currentState.selectedProject?.id == projectId
                  ? updatedProject
                  : currentState.selectedProject,
        ),
      );
    } catch (e) {
      emit(ProjectStateFailed(error: e.toString()));
    }
  }

  void selectProject(Project project) {
    if (!state.isLoaded) return;
    final currentState = state as ProjectStateLoaded;

    emit(
      ProjectStateLoaded(
        projects: currentState.projects,
        selectedProject: project,
      ),
    );
  }

  void clearSelectedProject() {
    if (!state.isLoaded) return;
    final currentState = state as ProjectStateLoaded;

    emit(
      ProjectStateLoaded(
        projects: currentState.projects,
        selectedProject: null,
      ),
    );
  }
}

typedef ProjectSelector<T> = BlocSelector<ProjectCubit, ProjectState, T>;
typedef ProjectListener = BlocListener<ProjectCubit, ProjectState>;
