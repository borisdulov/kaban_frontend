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
    return TaskAPIModel(
      taskId: json['_taskId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      tagId: json['tagId'] as String?,
      categoryId: json['categoryId'] as String,
      categoryList: List<String>.from(json['categoryList'] ?? []),
      userIds: List<String>.from(json['userIds'] ?? []),
      userList: List<String>.from(json['userList'] ?? []),
      isCompleted: json['isCompleted'] as bool,
      priority: TaskPriority.fromString(json['priority'] as String),
      dueDate:
          json['dueDate'] != null
              ? DateTime.parse(json['dueDate'] as String)
              : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'title': title,
      'description': description,
      'tagId': tagId,
      'categoryId': categoryId,
      'categoryList': categoryList,
      'userIds': userIds,
      'userList': userList,
      'isCompleted': isCompleted,
      'priority': priority.str,
      'dueDate': dueDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
