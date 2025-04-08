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
  Future<Project> removeMember(String projectId, String userId) {
    // TODO: implement removeMember
    throw UnimplementedError();
  }

  @override
  Future<Project> addMember(String projectId, String userId) {
    // TODO: implement addMember
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProject(String id) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }
}
