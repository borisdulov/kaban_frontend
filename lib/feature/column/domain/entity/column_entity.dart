import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

abstract interface class Column {
  String get id;
  String get title;
  String get color;

  String get boardId;
  Board? get board;

  List<String> get taskIds;
  List<Task> get tasks;
}
