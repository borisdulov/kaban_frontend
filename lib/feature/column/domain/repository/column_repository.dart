import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

abstract interface class ColumnRepository {
  Future<List<KanbanColumn>> getColumnsByProjectId(String projectId);
  Future<KanbanColumn> getColumnById(String id);
  Future<KanbanColumn> createColumn(KanbanColumn column);
  Future<KanbanColumn> updateColumn(String id, KanbanColumn column);
  Future<void> deleteColumn(String id);
  Future<KanbanColumn> addTask(String columnId, Task task);
  Future<List<KanbanColumn>> reorderColumns(String projectId, List<String> columnIds);
  Future<KanbanColumn> moveTask(String sourceColumnId, String targetColumnId,
      String taskId, int position);
}
