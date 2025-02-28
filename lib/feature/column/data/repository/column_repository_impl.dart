import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/column/domain/repository/column_repository.dart';
import 'package:kaban_frontend/feature/column/data/model/column_api_model.dart';

// final class ColumnRepositoryImpl implements ColumnRepository {
//   final ApiClient _apiClient;

//   ColumnRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

//   @override
//   Future<List<KanbanColumn>> getColumnsByProjectId(String projectId) async {
//     final response = await _apiClient.get('/projects/$projectId/columns');
//     final List<dynamic> data = response.data;
//     return data.map((json) => ColumnAPIModel.fromJSON(json)).toList();
//   }

//   @override
//   Future<KanbanColumn> getColumnById(String id) async {
//     final response = await _apiClient.get('/columns/$id');
//     return ColumnAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<KanbanColumn> createColumn(KanbanColumn column) async {
//     final columnModel = column as ColumnAPIModel;
//     final response =
//         await _apiClient.post('/columns', data: columnModel.toJSON());
//     return ColumnAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<KanbanColumn> updateColumn(String id, KanbanColumn column) async {
//     final columnModel = column as ColumnAPIModel;
//     final response =
//         await _apiClient.put('/columns/$id', data: columnModel.toJSON());
//     return ColumnAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<void> deleteColumn(String id) async {
//     await _apiClient.delete('/columns/$id');
//   }

//   @override
//   Future<KanbanColumn> addTask(String columnId, Task task) async {
//     final taskModel = task as TaskAPIModel;
//     final response = await _apiClient.post('/columns/$columnId/tasks',
//         data: taskModel.toJSON());
//     return ColumnAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<List<KanbanColumn>> reorderColumns(
//       String projectId, List<String> columnIds) async {
//     final response = await _apiClient.put(
//         '/projects/$projectId/columns/reorder',
//         data: {'columnIds': columnIds});
//     final List<dynamic> data = response.data;
//     return data.map((json) => ColumnAPIModel.fromJSON(json)).toList();
//   }

//   @override
//   Future<KanbanColumn> moveTask(String sourceColumnId, String targetColumnId,
//       String taskId, int position) async {
//     final response = await _apiClient
//         .put('/columns/$sourceColumnId/tasks/$taskId/move', data: {
//       'targetColumnId': targetColumnId,
//       'position': position,
//     });
//     return ColumnAPIModel.fromJSON(response.data);
//   }
// }
