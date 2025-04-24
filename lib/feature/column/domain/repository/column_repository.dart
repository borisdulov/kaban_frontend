import 'package:kaban_frontend/core/domain/entity/dependency.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';

abstract interface class ColumnRepository implements Dependency {
  Future<List<Column>> getColumnsByBoardId(String boardId);
  Future<Column> getColumnById(String id);
  Future<Column> createColumn(Column column);
  Future<Column> updateColumn(Column column);
  Future<void> deleteColumn(String id);
  // Future<List<Column>> reorderColumns(String boardId, List<String> columnIds);
}
