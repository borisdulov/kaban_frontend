// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

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
      title: 'Я устал сидеть в флютере',
      categoryId: 'test_category',
      isCompleted: true,
      priority: TaskPriority.medium,
      dueDate: DateTime(2025, 3, 2),
      createdAt: DateTime(2025, 3, 2),
    );
  }

  factory TaskMockModel.random() {
    final random = Random();
    return TaskMockModel(
      taskId: _randomId(),
      title: _randomTitle(),
      description: random.nextBool() ? _randomDescription() : null,
      tagId: random.nextBool() ? _randomTagId() : null,
      categoryId: _randomCategoryId(),
      categoryList:
          random.nextBool()
              ? List.generate(random.nextInt(3) + 1, (_) => _randomCategory())
              : null,
      userIds:
          random.nextBool()
              ? List.generate(random.nextInt(3) + 1, (_) => _randomUserId())
              : null,
      userList:
          random.nextBool()
              ? List.generate(random.nextInt(3) + 1, (_) => _randomUserName())
              : null,
      isCompleted: random.nextBool(),
      priority: TaskPriority.values[random.nextInt(TaskPriority.values.length)],
      dueDate:
          random.nextBool()
              ? DateTime.now().add(Duration(days: random.nextInt(30)))
              : null,
      createdAt: DateTime.now()
          .subtract(Duration(days: random.nextInt(30)))
          .add(Duration(hours: random.nextInt(24))),
    );
  }

  // Вспомогательные методы для генерации
  static String _randomId() => Random().nextInt(99999).toString();
  static String _randomTitle() =>
      [
        'Project X',
        'Bug Fix',
        'Meeting Notes',
        'Urgent Task',
        'Documentation',
      ][Random().nextInt(5)];
  static String _randomDescription() => 'Description ${Random().nextInt(1000)}';
  static String _randomTagId() => 'TAG_${Random().nextInt(100)}';
  static String _randomCategoryId() =>
      ['work', 'personal', 'shopping', 'health'][Random().nextInt(4)];
  static String _randomCategory() =>
      ['Development', 'Design', 'Testing', 'Research'][Random().nextInt(4)];
  static String _randomUserId() => 'user_${Random().nextInt(100)}';
  static String _randomUserName() =>
      ['Alice', 'Bob', 'Charlie', 'Diana', 'Eve'][Random().nextInt(5)];
}
