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
