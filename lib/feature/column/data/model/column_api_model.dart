import 'package:kaban_frontend/feature/board/data/model/board_api_model.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

class ColumnAPIModel implements Column {
  @override
  final String id;
  @override
  final String title;
  @override
  final String color;
  @override
  final String boardId;
  @override
  final Board? board;
  @override
  final List<String> taskIds;
  @override
  final List<Task> tasks;

  ColumnAPIModel({
    required this.id,
    required this.title,
    required this.color,
    required this.boardId,
    this.board,
    required this.taskIds,
    this.tasks = const [],
  });

  factory ColumnAPIModel.fromJSON(Map<String, dynamic> json) {
    String parseColor(String? hexColor) {
      if (hexColor == null || hexColor.isEmpty) {
        return '#757575';
      }
      return hexColor.startsWith('#') ? hexColor : '#$hexColor';
    }

    List<Task> tasks = [];
    List<String> taskIds = [];

    if (json['tasksId'] != null) {
      taskIds = List<String>.from(json['tasksId']);
    }

    if (json['tasks'] != null) {
      if (json['tasks'] is List) {
        final tasksList = json['tasks'] as List;

        if (tasksList.isNotEmpty) {
          if (tasksList.first is String) {
            taskIds = List<String>.from(tasksList);
          } else if (tasksList.first is Map<String, dynamic>) {
            tasks =
                tasksList
                    .map(
                      (taskJson) => TaskAPIModel.fromJSON(
                        taskJson as Map<String, dynamic>,
                      ),
                    )
                    .toList();
          }
        }
      }
    }

    String id = json['_id'] ?? json['id'] ?? '';

    return ColumnAPIModel(
      id: id,
      title: json['title'] ?? json['name'] ?? 'Без названия',
      color: parseColor(json['color']),
      boardId: json['boardId'] ?? json['board'] ?? '',
      board:
          json['board'] != null ? BoardAPIModel.fromJSON(json['board']) : null,
      taskIds: taskIds,
      tasks: tasks,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'title': title,
      'color': color,
      'boardId': boardId,
      'taskIds': taskIds,
    };
  }

  ColumnAPIModel copyWith({
    String? id,
    String? title,
    String? color,
    String? boardId,
    Board? board,
    List<String>? taskIds,
    List<Task>? tasks,
  }) {
    return ColumnAPIModel(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      boardId: boardId ?? this.boardId,
      board: board ?? this.board,
      taskIds: taskIds ?? this.taskIds,
      tasks: tasks ?? this.tasks,
    );
  }
}
