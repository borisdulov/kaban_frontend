// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';

class TaskAPIModel implements Task {
  @override
  final String taskId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? tagId;
  @override
  final String categoryId;
  @override
  final List<String>? categoryList;
  @override
  final List<String>? userIds;
  @override
  final List<String>? userList;
  @override
  final bool isCompleted;
  @override
  final TaskPriority priority;
  @override
  final DateTime? dueDate;
  @override
  final DateTime createdAt;

  TaskAPIModel({
    required this.taskId,
    required this.title,
    this.description,
    this.tagId,
    required this.categoryId,
    this.categoryList,
    this.userIds,
    this.userList,
    required this.isCompleted,
    required this.priority,
    this.dueDate,
    required this.createdAt,
  });

  factory TaskAPIModel.fromJSON(Map<String, dynamic> json) {
    try {
      return TaskAPIModel(
        taskId:
            json['_taskId'] ??
            json['_id'] ??
            json['id'] ??
            json['taskId'] ??
            '',
        title: json['title'] ?? 'Задача без названия',
        description: json['description'],
        tagId: json['tagId'],
        categoryId: json['categoryId'] ?? json['columnId'] ?? '',
        categoryList:
            json['categoryList'] != null
                ? List<String>.from(json['categoryList'])
                : [],
        userIds:
            json['userIds'] != null ? List<String>.from(json['userIds']) : [],
        userList:
            json['userList'] != null ? List<String>.from(json['userList']) : [],
        isCompleted: json['isCompleted'] ?? false,
        priority:
            json['priority'] != null
                ? TaskPriority.fromString(json['priority'])
                : TaskPriority.medium,
        dueDate:
            json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
        createdAt:
            json['createdAt'] != null
                ? DateTime.parse(json['createdAt'])
                : DateTime.now(),
      );
    } catch (e) {
      print('Ошибка при парсинге задачи: $e, JSON: $json');
      return TaskAPIModel(
        taskId: '',
        title: 'Ошибка загрузки',
        categoryId: '',
        isCompleted: false,
        priority: TaskPriority.medium,
        createdAt: DateTime.now(),
      );
    }
  }

  Map<String, dynamic> toJSON() {
    return {
      'columnId': categoryId,
      'title': title,
      'description': description ?? '',
      'isCompleted': isCompleted,
      'taskPriority': priority.str,
    };
  }
}
