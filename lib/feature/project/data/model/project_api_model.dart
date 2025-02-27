import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_privacy_enum.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class ProjectAPIModel implements Project {
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
  
  ProjectAPIModel({
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
  
  factory ProjectAPIModel.fromJSON(Map<String, dynamic> json) {
    return ProjectAPIModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      ownerId: json['ownerId'],
      owner: json['owner'],
      memberIds: List<String>.from(json['memberIds']),
      members: json['members'] ?? [],
      columnIds: List<String>.from(json['columnIds']),
      columns: json['columns'] ?? [],
      privacy: ProjectPrivacy.fromString(json['privacy']),
    );
  }
  
  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'description': description,
      'ownerId': ownerId,
      'memberIds': memberIds,
      'columnIds': columnIds,
      'privacy': privacy.str,
    };
  }
}