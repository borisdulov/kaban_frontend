import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart';
import 'package:kaban_frontend/feature/project/data/model/project_api_model.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';

class CategoryAPIModel implements Category {
  @override
  final String id;
  @override
  final String name;
  @override
  final Color color;
  @override
  final String projectId;
  @override
  final Project? project;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final int position;
  @override
  final List<String> taskIds;
  @override
  final List<Task>? tasks;

  CategoryAPIModel({
    required this.id,
    required this.name,
    required this.color,
    required this.projectId,
    this.project,
    required this.createdAt,
    required this.updatedAt,
    required this.position,
    required this.taskIds,
    this.tasks,
  });

  factory CategoryAPIModel.fromJSON(Map<String, dynamic> json) {
    Color parseColor(String hexColor) {
      hexColor = hexColor.replaceFirst('#', '');
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }
      return Color(int.parse(hexColor, radix: 16));
    }

    List<Task>? tasks;
    if (json['tasks'] != null) {
      tasks = (json['tasks'] as List)
          .map((taskJson) => TaskAPIModel.fromJSON(taskJson))
          .toList();
    }

    return CategoryAPIModel(
      id: json['_id'],
      name: json['name'],
      color: parseColor(json['color']),
      projectId: json['projectId'],
      project: json['project'] != null
          ? ProjectAPIModel.fromJSON(json['project'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      position: json['position'],
      taskIds: List<String>.from(json['taskIds'] ?? []),
      tasks: tasks,
    );
  }

  Map<String, dynamic> toJSON() {
    String colorToHex(Color color) {
      return '#${color.value.toRadixString(16).substring(2)}';
    }

    return {
      'name': name,
      'color': colorToHex(color),
      'projectId': projectId,
      'position': position,
      'taskIds': taskIds,
    };
  }

  CategoryAPIModel copyWith({
    String? id,
    String? name,
    Color? color,
    String? projectId,
    Project? project,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? position,
    List<String>? taskIds,
    List<Task>? tasks,
  }) {
    return CategoryAPIModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      projectId: projectId ?? this.projectId,
      project: project ?? this.project,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      position: position ?? this.position,
      taskIds: taskIds ?? this.taskIds,
      tasks: tasks ?? this.tasks,
    );
  }
}
