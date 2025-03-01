// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';

class TaskMockModel implements Task {
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

  const TaskMockModel({
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

  TaskMockModel copyWith({
    String? taskId,
    String? title,
    String? description,
    String? tagId,
    String? categoryId,
    List<String>? categoryList,
    List<String>? userIds,
    List<String>? userList,
    bool? isCompleted,
    TaskPriority? priority,
    DateTime? dueDate,
    DateTime? createdAt,
  }) {
    return TaskMockModel(
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      tagId: tagId ?? this.tagId,
      categoryId: categoryId ?? this.categoryId,
      categoryList: categoryList ?? this.categoryList,
      userIds: userIds ?? this.userIds,
      userList: userList ?? this.userList,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory TaskMockModel.mock() {
    return TaskMockModel(
      taskId: '1',
      title: 'test_title',
      categoryId: 'test_category',
      isCompleted: true,
      priority: TaskPriority.normal,
      createdAt: DateTime(2025, 3, 2),
    );
  }
}
