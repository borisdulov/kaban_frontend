import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart' hide Column;
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

final class ColumnMockModel implements Column {
  ColumnMockModel({
    required this.id,
    required this.title,
    required this.color,
    required this.boardId,
    this.board,
    required this.taskIds,
    this.tasks = const [],
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String color;
  @override
  final String boardId;
  @override
  final Board? board;
  @override
  final List<String> taskIds;
  @override
  final List<Task> tasks;

  factory ColumnMockModel.random() {
    final random = Random();

    final id = random.nextInt(100000).toString();

    final colorValue = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );

    final color = '#${colorValue.value.toRadixString(16).substring(2)}';

    final title =
        ['To Do', 'In Progress', 'Done', 'Backlog'][random.nextInt(4)];

    final boardId = '123';

    final numTasks = random.nextInt(6);

    final tasks = List.generate(
      numTasks,
      (_) => TaskMockModel.random().copyWith(columnId: id),
    );

    final taskIds = tasks.map((task) => task.id).toList();

    return ColumnMockModel(
      id: id,
      color: color,
      title: title,
      boardId: boardId,
      board: null,
      taskIds: taskIds,
      tasks: tasks,
    );
  }

  ColumnMockModel copyWith({
    String? id,
    String? title,
    String? color,
    String? boardId,
    Board? board,
    List<String>? taskIds,
    List<Task>? tasks,
  }) {
    return ColumnMockModel(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      boardId: boardId ?? this.boardId,
      board: board ?? this.board,
      taskIds: taskIds ?? this.taskIds,
      tasks: tasks ?? this.tasks,
    );
  }
}
