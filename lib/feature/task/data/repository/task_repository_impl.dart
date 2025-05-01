import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';

final class TaskRepositoryImpl implements TaskRepository {
  final ApiClient _apiClient;

  TaskRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Task> getTaskByColumnId(String columnId) async {
    final response = await _apiClient.get('/task/column/$columnId');
    return TaskAPIModel.fromJSON(response.data);
  }

  @override
  Future<Task> createTask(Task task) async {
    final taskModel = task as TaskAPIModel;
    final response = await _apiClient.post(
      '/task/create',
      data: taskModel.toJSON(),
    );
    return TaskAPIModel.fromJSON(response.data);
  }

  @override
  Future<Task> updateTask(Task task) async {
    final taskModel = task as TaskAPIModel;
    final response = await _apiClient.post(
      '/task/update',
      data: taskModel.toJSON(),
    );
    return TaskAPIModel.fromJSON(response.data);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _apiClient.get('/task/delete/$taskId');
  }

  @override
  Future<Task> getTask(String taskId) async {
    final response = await _apiClient.get('/task/getTask/$taskId');
    return TaskAPIModel.fromJSON(response.data);
  }

  @override
  Future<void> moveTaskToColumn(String taskId, String columnId) async {
    await _apiClient.post(
      '/task/moveTask',
      data: {'taskId': taskId, 'newColumnId': columnId},
    );
  }

  @override
  Future<List<Task>> getTasksByColumnId(String columnId) async {
    final response = await _apiClient.get('/task/column/all/$columnId');
    final List<dynamic> data = response.data;
    return data.map((json) => TaskAPIModel.fromJSON(json)).toList();
  }
}
