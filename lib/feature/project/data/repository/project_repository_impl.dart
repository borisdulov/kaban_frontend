import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/project/domain/repository/project_repository.dart';
import 'package:kaban_frontend/feature/project/data/model/project_api_model.dart';

// final class ProjectRepositoryImpl implements ProjectRepository {
//   final ApiClient _apiClient;

//   ProjectRepositoryImpl({required ApiClient apiClient})
//       : _apiClient = apiClient;

//   @override
//   Future<List<Project>> getAllProjects() async {
//     final response = await _apiClient.get('/projects');
//     final List<dynamic> data = response.data;
//     return data.map((json) => ProjectAPIModel.fromJSON(json)).toList();
//   }

//   @override
//   Future<Project> getProjectById(String id) async {
//     final response = await _apiClient.get('/projects/$id');
//     return ProjectAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<Project> createProject(Project project) async {
//     final projectModel = project as ProjectAPIModel;
//     final response = await _apiClient.post('/projects', data: projectModel.toJSON());
//     return ProjectAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<Project> updateProject(String id, Project project) async {
//     final projectModel = project as ProjectAPIModel;
//     final response = await _apiClient.put('/projects/$id', data: projectModel.toJSON());
//     return ProjectAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<void> deleteProject(String id) async {
//     await _apiClient.delete('/projects/$id');
//   }

//   @override
//   Future<Project> addMember(String projectId, String userId) async {
//     final response = await _apiClient.post('/projects/$projectId/members', data: {'userId': userId});
//     return ProjectAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<Project> removeMember(String projectId, String userId) async {
//     final response = await _apiClient.delete('/projects/$projectId/members/$userId');
//     return ProjectAPIModel.fromJSON(response.data);
//   }
// }
