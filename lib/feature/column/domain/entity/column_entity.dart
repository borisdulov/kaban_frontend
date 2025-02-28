import 'package:flutter/material.dart';

abstract interface class KanbanColumn {
  String get id;
  String get name;
  Color get color;
  String get projectId;
  DateTime get createdAt;
  DateTime get updatedAt;
  int get position;
  List<String> get taskIds;
  List<Task>? get tasks;
}
