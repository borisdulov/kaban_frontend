import 'dart:math';
import 'package:kaban_frontend/feature/category/data/model/category_mock_model.dart';
import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_privacy_enum.dart';
import 'package:kaban_frontend/feature/user/data/model/user_mock_model.dart';
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
  final List<User>? members;
  @override
  final List<String> categoryIds;
  @override
  final List<Category>? categories;
  @override
  final ProjectPrivacy privacy;

  ProjectMockModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.ownerId,
    this.owner,
    required this.memberIds,
    this.members,
    required this.categoryIds,
    this.categories,
    required this.privacy,
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
    List<String>? categoryIds,
    List<Category>? categories,
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
      categoryIds: categoryIds ?? this.categoryIds,
      categories: categories ?? this.categories,
      privacy: privacy ?? this.privacy,
    );
  }

  factory ProjectMockModel.random() {
    final random = Random();

    final id = random.nextInt(100000).toString();

    final name =
        [
          'Project Alpha',
          'Project Beta',
          'Project Gamma',
          'Project Delta',
        ][random.nextInt(4)];

    final description = 'Description ${random.nextInt(1000)}';

    final createdAt = DateTime.now().subtract(
      Duration(days: random.nextInt(365)),
    );

    final updatedAt = createdAt.add(Duration(days: random.nextInt(30)));

    final owner = UserMockModel.random();
    final ownerId = owner.id;

    final numMembers = random.nextInt(5);
    final members = List.generate(numMembers, (_) => UserMockModel.random());
    final memberIds = members.map((user) => user.id).toList();

    final numCategories = random.nextInt(5);
    final categories = List.generate(
      numCategories,
      (_) => CategoryMockModel.random().copyWith(projectId: id),
    );
    final categoryIds = categories.map((category) => category.id).toList();

    final privacy =
        ProjectPrivacy.values[random.nextInt(ProjectPrivacy.values.length)];

    return ProjectMockModel(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      ownerId: ownerId,
      owner: owner,
      memberIds: memberIds,
      members: members,
      categoryIds: categoryIds,
      categories: categories,
      privacy: privacy,
    );
  }
}
