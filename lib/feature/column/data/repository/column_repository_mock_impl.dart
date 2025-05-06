import 'package:kaban_frontend/feature/column/data/model/column_mock_model.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/column/domain/repository/column_repository.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

class ColumnRepositoryMockImpl implements ColumnRepository {
  final List<ColumnMockModel> _columns = [];
  int _idCounter = 1;

  ColumnRepositoryMockImpl() {
    // Инициализация тестовыми данными
    _columns.add(ColumnMockModel.random());
  }

  @override
  Future<Column> createColumn(Column column) async {
    final newColumn = ColumnMockModel(
      id: (_idCounter++).toString(),
      title: column.title,
      boardId: column.boardId,
      color: column.color,
      taskIds: column.taskIds,
    );
    _columns.add(newColumn);
    return newColumn;
  }

  @override
  Future<void> deleteColumn(String id) async {
    _columns.removeWhere((c) => c.id == id);
  }

  @override
  Future<Column> getColumnById(String id) async {
    return _columns.firstWhere((c) => c.id == id);
  }

  @override
  Future<List<Column>> getColumnsByBoardId(String boardId) async {
    return _columns.where((c) => c.boardId == boardId).toList();
  }

  @override
  Future<List<Task>> getTasksByColumnId(String columnId) async {
    // Здесь нужно подключить TaskRepository
    return [];
  }



  @override
  Future<Column> updateColumn(Column column) async {
    final index = _columns.indexWhere((c) => c.id == column.id);
    _columns[index] = ColumnMockModel(
      id: column.id,
      title: column.title,
      boardId: column.boardId,
      color: column.color,
      taskIds: column.taskIds,
    );
    return _columns[index];
  }
  
  @override
  Future<List<Column>> reorderColumns(String boardId, List<String> columnIds) {
    // TODO: implement reorderColumns
    throw UnimplementedError();
  }
}
