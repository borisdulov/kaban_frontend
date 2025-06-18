import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/column/data/model/column_api_model.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart'
    as column_entity;
import 'package:kaban_frontend/feature/column/domain/repository/column_repository.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/user/data/model/user_mock_model.dart';
import 'package:flutter/material.dart' hide Column;
import 'package:flutter/foundation.dart';

final class ColumnRepositoryImpl implements ColumnRepository {
  final ApiClient _apiClient;

  ColumnRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<column_entity.Column>> getColumnsByBoardId(String boardId) async {
    final response = await _apiClient.get('/column/getByBoard/$boardId');
    final List<dynamic> data = response.data;
    return data.map((json) => ColumnAPIModel.fromJSON(json)).toList();
  }

  @override
  Future<column_entity.Column> getColumnById(String id) async {
    final response = await _apiClient.get('/column/getColumn/$id');
    return ColumnAPIModel.fromJSON(response.data);
  }

  @override
  Future<column_entity.Column> createColumn(column_entity.Column column) async {
    final columnModel = column as ColumnAPIModel;
    final response = await _apiClient.post(
      '/column/create',
      data: columnModel.toJSON(),
    );
    return ColumnAPIModel.fromJSON(response.data);
  }

  @override
  Future<column_entity.Column> updateColumn(column_entity.Column column) async {
    final columnModel = column as ColumnAPIModel;
    final response = await _apiClient.post(
      '/column/update',
      data: columnModel.toJSON(),
    );
    return ColumnAPIModel.fromJSON(response.data);
  }

  @override
  Future<void> deleteColumn(String id) async {
    await _apiClient.get('/column/delete/$id');
  }

  @override
  Future<List<Task>> getTasksByColumnId(String columnId) async {
    try {
      final response = await _apiClient.get('/column/findTasks/$columnId');

      if (response.data is! List) {
        debugPrint(
          'Неверный формат данных при получении задач: ${response.data}',
        );
        return [];
      }

      final List<dynamic> data = response.data;
      return data.map((json) {
        if (json is! Map<String, dynamic>) {
          debugPrint('Неверный формат элемента в списке задач: $json');
          final creator = UserMockModel.mock();

          return TaskAPIModel(
            id: '',
            title: 'Ошибка формата',
            description: '',
            columnId: columnId,
            userIds: [],
            creatorId: creator.id,
            creator: creator,
            priority: TaskPriority.medium,
          );
        }
        return TaskAPIModel.fromJSON(json);
      }).toList();
    } catch (e) {
      debugPrint('Ошибка при получении задач для колонки $columnId: $e');
      return [];
    }
  }

  @override
  Future<List<column_entity.Column>> reorderColumns(
    String boardId,
    List<String> columnIds,
  ) async {
    final response = await _apiClient.post(
      '/column/reorder',
      data: {'boardId': boardId, 'columnIds': columnIds},
    );
    final List<dynamic> data = response.data;
    return data.map((json) => ColumnAPIModel.fromJSON(json)).toList();
  }
}
