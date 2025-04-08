import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart';
import 'package:kaban_frontend/feature/board/domain/entity/project_privacy_enum.dart';
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
  List<User>? get members;
  List<String> get categoryIds;
  List<Category>? get categories;
  ProjectPrivacy get privacy;
}
