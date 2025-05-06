import 'package:flutter/foundation.dart';
import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/column/data/model/column_api_model.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart'
    as column_entity;
import 'package:kaban_frontend/feature/column/domain/repository/column_repository.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';

final class ColumnRepositoryApiImpl implements ColumnRepository {
  final ApiClient _apiClient;

  ColumnRepositoryApiImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<column_entity.Column>> getColumnsByBoardId(String boardId) async {
    try {
      final response = await _apiClient.get('/board/$boardId');
      final Map<String, dynamic> data = response.data;

      List<String> columnIds = [];
      if (data['columns'] != null && data['columns'] is List) {
        columnIds = List<String>.from(data['columns']);
      } else if (data['columnsId'] != null && data['columnsId'] is List) {
        columnIds = List<String>.from(data['columnsId']);
      }

      final List<column_entity.Column> columns = [];

      for (final columnId in columnIds) {
        try {
          final columnResponse = await _apiClient.get(
            '/column/getColumn/$columnId',
          );
          final columnData = columnResponse.data;

          final column = ColumnAPIModel.fromJSON(columnData);

          try {
            final tasksResponse = await _apiClient.get(
              '/column/findTasks/$columnId',
            );
            final List<dynamic> tasksData = tasksResponse.data;

            final tasks =
                tasksData
                    .map((taskJson) => TaskAPIModel.fromJSON(taskJson))
                    .toList();

            columns.add((column).copyWith(tasks: tasks));
          } catch (e) {
            debugPrint('Error fetching tasks for column $columnId: $e');
            columns.add(column);
          }
        } catch (e) {
          debugPrint('Error fetching column $columnId: $e');
        }
      }

      return columns;
    } catch (e) {
      debugPrint('Error getting columns for board $boardId: $e');
      rethrow;
    }
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

  // @override
  // Future<List<column_entity.Column>> reorderColumns(
  //   String boardId,
  //   List<String> columnIds,
  // ) async {
  //   final response = await _apiClient.post(
  //     '/column/reorder',
  //     data: {'boardId': boardId, 'columnIds': columnIds},
  //   );
  //   final List<dynamic> data = response.data;
  //   return data.map((json) => ColumnAPIModel.fromJSON(json)).toList();
  // }
}
