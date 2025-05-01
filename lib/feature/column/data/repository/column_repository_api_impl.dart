import 'package:flutter/foundation.dart';
import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/column/data/model/column_api_model.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart'
    as column_entity;
import 'package:kaban_frontend/feature/column/domain/repository/column_repository.dart';

final class ColumnRepositoryApiImpl implements ColumnRepository {
  final ApiClient _apiClient;

  ColumnRepositoryApiImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<column_entity.Column>> getColumnsByBoardId(String boardId) async {
    try {
      final response = await _apiClient.get('/board/$boardId');
      final Map<String, dynamic> data = response.data;

      final List<dynamic> columnsData = data['columns'] ?? [];
      final List<column_entity.Column> columns = [];

      for (final item in columnsData) {
        try {
          if (item is Map<String, dynamic>) {
            columns.add(ColumnAPIModel.fromJSON(item));
          } else if (item is String) {
            final columnResponse = await _apiClient.get(
              '/column/getColumn/$item',
            );
            columns.add(ColumnAPIModel.fromJSON(columnResponse.data));
          }
        } catch (e) {
          debugPrint('Error parsing column data: $e');
        }
      }

      if (columns.isEmpty && data['columnIds'] != null) {
        final List<dynamic> columnIds = data['columnIds'];
        for (final id in columnIds) {
          try {
            if (id is String) {
              final columnResponse = await _apiClient.get(
                '/column/getColumn/$id',
              );
              columns.add(ColumnAPIModel.fromJSON(columnResponse.data));
            }
          } catch (e) {
            debugPrint('Error fetching column $id: $e');
          }
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
