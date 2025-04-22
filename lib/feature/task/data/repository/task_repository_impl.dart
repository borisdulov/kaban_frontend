import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';

final class TaskRepositoryImpl implements TaskRepository {
  final ApiClient _apiClient;

  TaskRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<Task>> getAllTasks() async {
    final response = await _apiClient.get('/task');
    final List<dynamic> data = response.data;
    return data.map((json) => TaskAPIModel.fromJSON(json)).toList();
  }

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
  Future<void> giveTask(String userId, String taskId) async {
    await _apiClient.post(
      '/task/giveTask',
      data: {'userId': userId, 'taskId': taskId},
    );
  }

  @override
  Future<List<Task>> searchTasks() async {
    final response = await _apiClient.get('/task/search');
    final List<dynamic> data = response.data;
    return data.map((json) => TaskAPIModel.fromJSON(json)).toList();
  }

  @override
  Future<List<Task>> filterTasks({
    List<String>? userIds,
    TaskPriority? priority,
    List<String>? tags,
    DateTime? dueDate,
    String? boardId,
  }) async {
    final Map<String, dynamic> queryParams = {};

    if (userIds != null && userIds.isNotEmpty) {
      queryParams['userIds'] = userIds.join(',');
    }

    if (priority != null) {
      queryParams['priority'] = priority.str;
    }

    if (tags != null && tags.isNotEmpty) {
      queryParams['tags'] = tags.join(',');
    }

    if (dueDate != null) {
      queryParams['dueDate'] = dueDate.toIso8601String();
    }

    if (boardId != null) {
      queryParams['boardId'] = boardId;
    }

    final response = await _apiClient.get(
      '/task/filter',
      queryParameters: queryParams,
    );
    final List<dynamic> data = response.data;
    return data.map((json) => TaskAPIModel.fromJSON(json)).toList();
  }
}
