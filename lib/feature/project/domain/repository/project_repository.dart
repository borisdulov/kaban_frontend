import 'package:kaban_frontend/core/domain/entity/dependency.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';

abstract interface class ProjectRepository implements Dependency {
  Future<List<Project>> getAllProjects();
  Future<Project> getProjectById(String id);
  Future<Project> createProject(Project project);
  Future<Project> updateProject(String id, Project project);
  Future<void> deleteProject(String id);
  Future<Project> addMember(String projectId, String userId);
  Future<Project> removeMember(String projectId, String userId);
}
