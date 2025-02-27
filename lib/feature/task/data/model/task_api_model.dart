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
  final List<String>? subtasks;
  @override
  final List<String>? tags;
  @override
  final String projectId;
  @override
  final String columnId;
  @override
  final List<String>? subtaskIds;
  @override
  final List<String>? userIds;
  @override
  final bool isCompleted;
  @override
  final TaskPriority priority;
  @override
  final DateTime? dueDate;

  TaskAPIModel({
    required this.taskId,
    required this.title,
    this.description,
    this.subtasks,
    this.tags,
    required this.projectId,
    required this.columnId,
    this.subtaskIds,
    this.userIds,
    required this.isCompleted,
    required this.priority,
    this.dueDate,
  });

  factory TaskAPIModel.fromJSON(Map<String, dynamic> json) {
    return TaskAPIModel(
      taskId: json['_taskId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      subtasks: List<String>.from(json['subtasks'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      projectId: json['projectId'] as String,
      columnId: json['columnId'] as String,
      subtaskIds: List<String>.from(json['subtaskIds'] ?? []),
      userIds: List<String>.from(json['assigneeIds'] ?? []),
      isCompleted: json['isCompleted'] as bool,
      priority: TaskPriority.fromString(json['priority'] as String),
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'title': title,
      'description': description,
      'subtasks': subtasks,
      'tags': tags,
      'projectId': projectId,
      'columnId': columnId,
      'subtaskIds': subtaskIds,
      'userIds': userIds,
      'isCompleted': isCompleted,
      'priority': priority.str,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
