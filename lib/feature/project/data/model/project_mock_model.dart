// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_privacy_enum.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class ProjectMockModel implements Project {
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

  ProjectMockModel({
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

  ProjectMockModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? ownerId,
    User? owner,
    List<String>? memberIds,
    List<User>? members,
    List<String>? columnIds,
    List<Column>? columns,
    ProjectPrivacy? privacy,
  }) {
    return ProjectMockModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ownerId: ownerId ?? this.ownerId,
      owner: owner ?? this.owner,
      memberIds: memberIds ?? this.memberIds,
      members: members ?? this.members,
      columnIds: columnIds ?? this.columnIds,
      columns: columns ?? this.columns,
      privacy: privacy ?? this.privacy,
    );
  }

  factory ProjectMockModel.mock() {
    return ProjectMockModel(
      id: '1',
      name: 'Project Kaban',
      description: 'this description',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerId: '1',
      memberIds: ['1', '2'],
      columnIds: ['1', '2'],
      privacy: ProjectPrivacy.private,
    );
  }
}
