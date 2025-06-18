import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

abstract interface class Task {
  String get id;
  String get title;
  String get description;

  String get columnId;
  Column? get column;

  List<String> get userIds;
  List<User> get users;

  String get creatorId;
  User get creator;

  TaskPriority? get priority;
  DateTime? get dueDate;
  bool get isCompleted;
}
