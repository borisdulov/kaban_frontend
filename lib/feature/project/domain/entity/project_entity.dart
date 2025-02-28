import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_privacy_enum.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

abstract interface class Project {
  String get id;
  String get name;
  String get description;
  DateTime get createdAt;
  DateTime get updatedAt;
  String get ownerId;
  User? get owner;
  List<String> get memberIds;
  List<User> get members;
  List<String> get columnIds;
  List<Column> get columns;
  ProjectPrivacy get privacy;
}
