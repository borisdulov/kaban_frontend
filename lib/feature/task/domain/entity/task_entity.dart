import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';

abstract interface class Task {
  String get taskId;
  String get title;
  String? get description;
  List<String>? get subtasks;
  List<String>? get tags;
  String get projectId;
  String get columnId;
  List<String>? get subtaskIds;
  List<String>? get userIds;
  bool get isCompleted;
  TaskPriority get priority;
  DateTime? get dueDate;
}