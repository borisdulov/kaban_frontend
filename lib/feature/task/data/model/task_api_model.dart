// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/user/data/model/user_model.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class TaskAPIModel implements Task {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String columnId;
  @override
  final Column? column;
  @override
  final List<String> userIds;
  @override
  final List<User> users;
  @override
  final String creatorId;
  @override
  final User creator;
  @override
  final TaskPriority? priority;
  @override
  final DateTime? dueDate;
  @override
  final bool isCompleted;

  TaskAPIModel({
    required this.id,
    required this.title,
    required this.description,
    required this.columnId,
    this.column,
    required this.userIds,
    this.users = const [],
    required this.creatorId,
    required this.creator,
    this.priority,
    this.dueDate,
    this.isCompleted = false,
  });

  factory TaskAPIModel.fromJSON(Map<String, dynamic> json) {
    try {
      User defaultCreator = UserAPIModel(
        id: json['creatorId'] ?? '',
        login: 'unknown',
      );

      return TaskAPIModel(
        id: json['_id'] ?? json['id'] ?? json['taskId'] ?? '',
        title: json['title'] ?? 'Задача без названия',
        description: json['description'] ?? '',
        columnId: json['columnId'] ?? '',
        userIds:
            json['userIds'] != null ? List<String>.from(json['userIds']) : [],
        creatorId: json['creatorId'] ?? '',
        creator:
            json['creator'] != null
                ? UserAPIModel.fromMap(json['creator'])
                : defaultCreator,
        priority:
            json['priority'] != null
                ? TaskPriority.fromString(json['priority'])
                : (json['taskPriority'] != null
                    ? TaskPriority.fromString(json['taskPriority'])
                    : null),
        dueDate:
            json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
        isCompleted: json['isCompleted'] ?? false,
      );
    } catch (e) {
      print('Ошибка при парсинге задачи: $e, JSON: $json');

      User defaultCreator = UserAPIModel(id: '', login: 'system');

      return TaskAPIModel(
        id: '',
        title: 'Ошибка загрузки',
        description: '',
        columnId: '',
        userIds: [],
        creatorId: '',
        creator: defaultCreator,
        isCompleted: false,
      );
    }
  }

  Map<String, dynamic> toJSON() {
    return {
      'title': title,
      'description': description,
      'columnId': columnId,
      'userIds': userIds,
      'creatorId': creatorId,
      'taskPriority': priority?.str ?? 'none',
      'isCompleted': false,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
