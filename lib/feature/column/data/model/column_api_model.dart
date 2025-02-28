import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';

class ColumnAPIModel implements KanbanColumn {
  @override
  final String id;
  @override
  final String name;
  @override
  final Color color;
  @override
  final String projectId;
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

  ColumnAPIModel({
    required this.id,
    required this.name,
    required this.color,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
    required this.position,
    required this.taskIds,
    this.tasks,
  });

  factory ColumnAPIModel.fromJSON(Map<String, dynamic> json) {
    Color parseColor(String hexColor) {
      hexColor = hexColor.replaceFirst('#', '');
      if (hexColor.length == 6) {
        hexColor = 'FF' + hexColor;
      }
      return Color(int.parse(hexColor, radix: 16));
    }

    List<Task>? tasks;
    if (json['tasks'] != null) {
      tasks = (json['tasks'] as List)
          .map((taskJson) => TaskAPIModel.fromJSON(taskJson))
          .toList();
    }

    return ColumnAPIModel(
      id: json['_id'],
      name: json['name'],
      color: parseColor(json['color']),
      projectId: json['projectId'],
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

  ColumnAPIModel copyWith({
    String? id,
    String? name,
    Color? color,
    String? projectId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? position,
    List<String>? taskIds,
    List<Task>? tasks,
  }) {
    return ColumnAPIModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      projectId: projectId ?? this.projectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      position: position ?? this.position,
      taskIds: taskIds ?? this.taskIds,
      tasks: tasks ?? this.tasks,
    );
  }
}
