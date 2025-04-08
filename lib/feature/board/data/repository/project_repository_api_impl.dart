import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/board/data/model/project_api_model.dart';
import 'package:kaban_frontend/feature/board/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/board/domain/repository/project_repository.dart';

final class ProjectRepositoryImpl implements ProjectRepository {
  final ApiClient _apiClient;

  ProjectRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<Project>> getAllProjects() async {
    final response = await _apiClient.get('/board');
    final List<dynamic> data = response.data;
    return data.map((json) => ProjectAPIModel.fromJSON(json)).toList();
  }

  @override
  Future<Project> getProjectById(String id) async {
    final response = await _apiClient.get('/board/$id');

    return ProjectAPIModel.fromJSON(response.data);
  }

  @override
  Future<Project> addMember(String projectId, String userId) {
    // TODO: implement addMember
    throw UnimplementedError();
  }

  @override
  Future<Project> createProject(Project project) {
    // TODO: implement createProject
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProject(String id) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Future<Project> removeMember(String projectId, String userId) {
    // TODO: implement removeMember
    throw UnimplementedError();
  }

  @override
  Future<Project> updateProject(String id, Project project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }
}
