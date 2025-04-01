import 'package:kaban_frontend/feature/board/data/model/project_mock_model.dart';
import 'package:kaban_frontend/feature/board/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/board/domain/repository/project_repository.dart';

final class ProjectRepositoryMockImpl implements ProjectRepository {
  final List<ProjectMockModel> _projects = [ProjectMockModel.random()];

  @override
  Future<List<Project>> getAllProjects() async {
    return Future.value(_projects);
  }

  @override
  Future<Project> getProjectById(String id) async {
    return Future.value(
      _projects.firstWhere(
        (project) => project.id == id,
        orElse: () => ProjectMockModel.random(),
      ),
    );
  }

  @override
  Future<Project> createProject(Project project) async {
    final newProject = ProjectMockModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: project.name,
      description: project.description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerId: project.ownerId,
      memberIds: project.memberIds,
      categoryIds: project.categoryIds,
      privacy: project.privacy,
      owner: project.owner,
      members: project.members,
      categories: project.categories,
    );
    _projects.add(newProject);
    return Future.value(newProject);
  }

  @override
  Future<Project> updateProject(String id, Project project) async {
    final index = _projects.indexWhere((p) => p.id == id);
    if (index != -1) {
      _projects[index] = ProjectMockModel(
        id: id,
        name: project.name,
        description: project.description,
        createdAt: project.createdAt,
        updatedAt: DateTime.now(),
        ownerId: project.ownerId,
        memberIds: project.memberIds,
        categoryIds: project.categoryIds,
        privacy: project.privacy,
        owner: project.owner,
        members: project.members,
        categories: project.categories,
      );
      return Future.value(_projects[index]);
    }
    throw Exception("Project not found");
  }

  @override
  Future<void> deleteProject(String id) async {
    _projects.removeWhere((project) => project.id == id);
    return Future.value();
  }

  @override
  Future<Project> addMember(String projectId, String userId) async {
    final project = _projects.firstWhere((p) => p.id == projectId);
    final updatedProject = project.copyWith(
      memberIds: [...project.memberIds, userId],
    );
    final index = _projects.indexWhere((p) => p.id == projectId);
    _projects[index] = updatedProject;
    return Future.value(updatedProject);
  }

  @override
  Future<Project> removeMember(String projectId, String userId) async {
    final project = _projects.firstWhere((p) => p.id == projectId);
    final updatedProject = project.copyWith(
      memberIds: project.memberIds.where((id) => id != userId).toList(),
    );
    final index = _projects.indexWhere((p) => p.id == projectId);
    _projects[index] = updatedProject;
    return Future.value(updatedProject);
  }
}
