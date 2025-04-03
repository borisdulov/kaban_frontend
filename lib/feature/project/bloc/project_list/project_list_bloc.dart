import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/project/bloc/project_list/project_list_state.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/project/domain/repository/project_repository.dart';

extension ProjectListExtension on BuildContext {
  ProjectListCubit get projectCubit => read<ProjectListCubit>();
}

typedef ProjectListBuilder = BlocBuilder<ProjectListCubit, ProjectListState>;

class ProjectListCubit extends Cubit<ProjectListState> {
  final ProjectRepository _projectRepository;

  ProjectListCubit({required ProjectRepository projectRepository})
    : _projectRepository = projectRepository,
      super(const ProjectListState(status: Status.loading)) {
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final projects = await _projectRepository.getAllProjects();
      emit(ProjectListState(status: Status.success, projects: projects));
    } catch (e) {
      emit(ProjectListState(status: Status.failure, error: e.toString()));
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
}

typedef ProjectSelector<T> =
    BlocSelector<ProjectListCubit, ProjectListState, T>;
typedef ProjectListener = BlocListener<ProjectListCubit, ProjectListState>;

