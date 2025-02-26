import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/task/domain/entity/project_privacy_enum.dart';

class ProjectDBModel implements Project {
  @override
  final String id;
  
  @override
  final String name;
  
  @override
  final String description;
  
  @override
  final DateTime createdAt;
  
  @override
  final DateTime updatedAt;
  
  @override
  final String ownerId;
  
  @override
  final User? owner;
  
  @override
  final List<String> memberIds;
  
  @override
  final List<User> members;
  
  @override
  final List<String> columnIds;
  
  @override
  final List<Column> columns;
  
  @override
  final ProjectPrivacy privacy;
  
  ProjectDBModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.ownerId,
    required this.memberIds,
    required this.columnIds,
    required this.privacy,
    this.owner,
    this.members = const [],
    this.columns = const [],
  });
  
  factory ProjectDBModel.fromMap(Map<String, dynamic> map) {
    return ProjectDBModel(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      ownerId: map['owner_id'],
      memberIds: List<String>.from(map['member_ids']),
      columnIds: List<String>.from(map['column_ids']),
      privacy: ProjectPrivacy.fromString(map['privacy']),
      owner: null,
      members: [],
      columns: [],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'owner_id': ownerId,
      'member_ids': memberIds,
      'column_ids': columnIds,
      'visibility': privacy.str,
    };
  }
}