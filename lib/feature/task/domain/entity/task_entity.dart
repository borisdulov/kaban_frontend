import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';

abstract interface class Task {
  String get taskId;
  String get title;
  String? get description;
  String? get tagId;
  String get categoryId;
  List<String>? get categoryList;
  List<String>? get userIds;
  List<String>? get userList;
  bool get isCompleted;
  TaskPriority get priority;
  DateTime? get dueDate;
  DateTime get createdAt;
}
