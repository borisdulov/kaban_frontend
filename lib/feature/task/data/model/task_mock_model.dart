// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/user/data/model/user_mock_model.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class TaskMockModel implements Task {
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

  TaskMockModel({
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
  });

  TaskMockModel copyWith({
    String? id,
    String? title,
    String? description,
    String? columnId,
    Column? column,
    List<String>? userIds,
    List<User>? users,
    String? creatorId,
    User? creator,
    TaskPriority? priority,
    DateTime? dueDate,
  }) {
    return TaskMockModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      columnId: columnId ?? this.columnId,
      column: column ?? this.column,
      userIds: userIds ?? this.userIds,
      users: users ?? this.users,
      creatorId: creatorId ?? this.creatorId,
      creator: creator ?? this.creator,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  factory TaskMockModel.mock() {
    final creator = UserMockModel.mock();

    return TaskMockModel(
      id: '1',
      title: 'Я устал сидеть в флютере',
      description: 'Описание задачи',
      columnId: 'test_column',
      userIds: ['1', '2'],
      creatorId: creator.id,
      creator: creator,
    );
  }

  factory TaskMockModel.empty() {
    final creator = UserMockModel.mock();

    return TaskMockModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: '',
      description: '',
      columnId: 'default',
      userIds: [],
      creatorId: creator.id,
      creator: creator,
    );
  }

  factory TaskMockModel.random() {
    final random = Random();
    final creator = UserMockModel.random();

    final id = _randomId();
    final title = _randomTitle();
    final description = _randomDescription();
    final columnId = _randomColumnId();

    final numUsers = random.nextInt(3);
    final userIds = List.generate(numUsers, (_) => _randomUserId());
    final users = List.generate(numUsers, (_) => UserMockModel.random());

    final includePriority = random.nextBool();
    final priority =
        includePriority
            ? TaskPriority.values[random.nextInt(TaskPriority.values.length)]
            : null;

    final includeDueDate = random.nextBool();
    final dueDate =
        includeDueDate
            ? DateTime.now().add(Duration(days: random.nextInt(10)))
            : null;

    return TaskMockModel(
      id: id,
      title: title,
      description: description,
      columnId: columnId,
      userIds: userIds,
      users: users,
      creatorId: creator.id,
      creator: creator,
      priority: priority,
      dueDate: dueDate,
    );
  }

  static String _randomId() => Random().nextInt(99999).toString();
  static String _randomTitle() =>
      [
        'Board X',
        'Bug Fix',
        'Meeting Notes',
        'Urgent Task',
        'Documentation',
      ][Random().nextInt(5)];
  static String _randomDescription() => 'Description ${Random().nextInt(1000)}';
  static String _randomColumnId() =>
      ['work', 'personal', 'shopping', 'health'][Random().nextInt(4)];
  static String _randomUserId() => 'user_${Random().nextInt(100)}';

  @override
  // TODO: implement isCompleted
  bool get isCompleted => throw UnimplementedError();
}
