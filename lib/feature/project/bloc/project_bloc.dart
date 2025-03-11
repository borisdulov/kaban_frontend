import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/project/domain/repository/project_repository.dart';
import 'package:kaban_frontend/feature/project/bloc/project_state.dart';

extension ProjectExtension on BuildContext {
  ProjectCubit get projectCubit => read<ProjectCubit>();
}

typedef ProjectBuilder = BlocBuilder<ProjectCubit, ProjectState>;

class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepository _projectRepository;

  ProjectCubit({required ProjectRepository projectRepository})
    : _projectRepository = projectRepository,
      super(const ProjectState(status: Status.loading)) {
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final projects = await _projectRepository.getAllProjects();
      emit(ProjectState(status: Status.success, projects: projects));
    } catch (e) {
      emit(ProjectState(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> fetchProjectById(String id) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final project = await _projectRepository.getProjectById(id);
      emit(
        state.copyWith(
          status: Status.success,
          projects: [...state.projects.where((p) => p.id != id), project],
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> createProject(Project project) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final createdProject = await _projectRepository.createProject(project);
      emit(
        state.copyWith(
          status: Status.success,
          projects: [...state.projects, createdProject],
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> updateProject(Project project) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final updatedProject = await _projectRepository.updateProject(
        project.id,
        project,
      );

      final updatedProjects =
          state.projects.map((p) {
            return p.id == project.id ? updatedProject : p;
          }).toList();

      emit(state.copyWith(status: Status.success, projects: updatedProjects));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> deleteProject(String id) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      await _projectRepository.deleteProject(id);

      final updatedProjects = state.projects.where((p) => p.id != id).toList();

      emit(state.copyWith(status: Status.success, projects: updatedProjects));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> addMember(String projectId, String userId) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final updatedProject = await _projectRepository.addMember(
        projectId,
        userId,
      );

      final updatedProjects =
          state.projects.map((p) {
            return p.id == projectId ? updatedProject : p;
          }).toList();

      emit(state.copyWith(status: Status.success, projects: updatedProjects));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> removeMember(String projectId, String userId) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final updatedProject = await _projectRepository.removeMember(
        projectId,
        userId,
      );

      final updatedProjects =
          state.projects.map((p) {
            return p.id == projectId ? updatedProject : p;
          }).toList();

      emit(state.copyWith(status: Status.success, projects: updatedProjects));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}

typedef ProjectSelector<T> = BlocSelector<ProjectCubit, ProjectState, T>;
typedef ProjectListener = BlocListener<ProjectCubit, ProjectState>;
