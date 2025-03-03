import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

abstract interface class Category {
  String get id;
  String get name;
  Color get color;
  String get projectId;
  Project? get project;
  DateTime get createdAt;
  DateTime get updatedAt;
  int get position;
  List<String> get taskIds;
  List<Task>? get tasks;
}
