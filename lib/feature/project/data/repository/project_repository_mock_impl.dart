

// import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
// import 'package:kaban_frontend/feature/project/domain/repository/project_repository.dart';
// import 'package:kaban_frontend/feature/project/data/model/project_api_model.dart';

// final class MockProjectRepository implements ProjectRepository {
//   final List<ProjectAPIModel> _projects = [];
//   int _idCounter = 1;

//   @override
//   Future<List<Project>> getAllProjects() async {
//     return Future.value(_projects);
//   }

//   @override
//   Future<Project> getProjectById(String id) async {
//     return Future.value(_projects.firstWhere((project) => project.id == id));
//   }

//   @override
//   Future<Project> createProject(Project project) async {
//     final newProject = ProjectAPIModel(
//       id: _idCounter.toString(),
//       name: project.name,
//       description: project.description,
//     );
//     _projects.add(newProject);
//     _idCounter++;
//     return Future.value(newProject);
//   }

//   @override
//   Future<Project> updateProject(String id, Project project) async {
//     final index = _projects.indexWhere((p) => p.id == id);
//     if (index != -1) {
//       _projects[index] = ProjectAPIModel(
//         id: id,
//         name: project.name,
//         description: project.description,
//       );
//       return Future.value(_projects[index]);
//     }
//     throw Exception("Project not found");
//   }

//   @override
//   Future<void> deleteProject(String id) async {
//     _projects.removeWhere((project) => project.id == id);
//     return Future.value();
//   }

//   @override
//   Future<Project> addMember(String projectId, String userId) async {
//     final project = _projects.firstWhere((p) => p.id == projectId);
//     project.members.add(userId);
//     return Future.value(project);
//   }

//   @override
//   Future<Project> removeMember(String projectId, String userId) async {
//     final project = _projects.firstWhere((p) => p.id == projectId);
//     project.members.remove(userId);
//     return Future.value(project);
//   }
// }