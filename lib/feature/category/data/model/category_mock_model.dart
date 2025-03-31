import 'dart:math';
import 'dart:ui';
import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

final class CategoryMockModel implements Category {
  CategoryMockModel({
    required this.color,
    required this.createdAt,
    required this.id,
    required this.name,
    required this.position,
    required this.project,
    required this.projectId,
    required this.taskIds,
    required this.tasks,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final Color color;
  @override
  final DateTime createdAt;
  @override
  final String name;
  @override
  final int position;
  @override
  final Project? project;
  @override
  final String projectId;
  @override
  final List<String> taskIds;
  @override
  final List<Task>? tasks;
  @override
  final DateTime updatedAt;

  factory CategoryMockModel.random() {
    final random = Random();

    final id = random.nextInt(100000).toString();

    final color = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );

    final createdAt = DateTime.now().subtract(
      Duration(days: random.nextInt(365)),
    );

    final name = ['To Do', 'In Progress', 'Done', 'Backlog'][random.nextInt(4)];

    final position = random.nextInt(11);

    final project = null;

    final projectId = '123';

    final numTasks = random.nextInt(6);

    final tasks = List.generate(
      numTasks,
      (_) => TaskMockModel.random().copyWith(categoryId: id),
    );

    final taskIds = tasks.map((task) => task.taskId).toList();

    final updatedAt = createdAt.add(Duration(days: random.nextInt(30)));

    return CategoryMockModel(
      id: id,
      color: color,
      createdAt: createdAt,
      name: name,
      position: position,
      project: project,
      projectId: projectId,
      taskIds: taskIds,
      tasks: tasks,
      updatedAt: updatedAt,
    );
  }

  CategoryMockModel copyWith({
    String? id,
    Color? color,
    DateTime? createdAt,
    String? name,
    int? position,
    Project? project,
    String? projectId,
    List<String>? taskIds,
    List<Task>? tasks,
    DateTime? updatedAt,
  }) {
    return CategoryMockModel(
      id: id ?? this.id,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      position: position ?? this.position,
      project: project ?? this.project,
      projectId: projectId ?? this.projectId,
      taskIds: taskIds ?? this.taskIds,
      tasks: tasks ?? this.tasks,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
