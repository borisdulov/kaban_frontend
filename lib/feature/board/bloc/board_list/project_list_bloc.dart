import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/board/data/model/project_mock_model.dart';
import 'package:kaban_frontend/feature/project/data/repository/project_repository_mock_impl.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/project_list_state.dart';
import 'package:kaban_frontend/feature/board/domain/repository/project_repository.dart';

extension ProjectListExtension on BuildContext {
  ProjectListCubit get boardListCubit => read<ProjectListCubit>();
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
      emit(
        ProjectListState(
          status: Status.success,
          boards: projects,
          editingBoardId: null,
        ),
      );
    } catch (e) {
      emit(
        ProjectListState(
          status: Status.failure,
          error: e.toString(),
          editingBoardId: null,
        ),
      );
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
          projects: [...state.boards.where((p) => p.id != id), project],
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> createProject() async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final newProject = ProjectMockModel.random();
      await _projectRepository.createProject(newProject);

      final updatedProjects = await _projectRepository.getAllProjects();
      emit(state.copyWith(status: Status.success, projects: updatedProjects));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  void startEditing(String boardId) {
    emit(state.copyWith(editingBoardId: boardId));
  }

  Future<void> renameProject(String projectId, String newName) async {
    final projectId = state.editingBoardId;
    if (projectId == null) return;
    final project =
        state.boards.firstWhere((p) => p.id == projectId) as ProjectMockModel;
    final updatedProject = project.copyWith(name: newName);
    try {
      await _projectRepository.updateProject(projectId, updatedProject);

      final newProjects =
          state.boards
              .map((p) => p.id == projectId ? updatedProject : p)
              .toList();

      emit(state.copyWith(projects: newProjects, editingBoardId: null));
    } catch (e) {
      emit(state.copyWith(editingBoardId: null));
    }
  }

  static BlocProvider<ProjectListCubit> provider({required String projectId}) {
    return BlocProvider(
      create:
          (context) =>
              ProjectListCubit(projectRepository: ProjectRepositoryMockImpl()),
    );
  }
}

typedef ProjectSelector<T> =
    BlocSelector<ProjectListCubit, ProjectListState, T>;
typedef ProjectListener = BlocListener<ProjectListCubit, ProjectListState>;
