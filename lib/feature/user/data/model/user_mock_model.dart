// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class UserMockModel implements User {
  @override
  final String id;
  @override
  final String? email;
  @override
  final String login;
  @override
  final String? bio;
  @override
  final String? username;
  @override
  final String? avatar;
  @override
  final List<String>? projectsIds;

  const UserMockModel({
    required this.id,
    this.email,
    required this.login,
    this.username,
    this.bio,
    this.avatar,
    this.projectsIds = const [],
  });

  UserMockModel copyWith({
    String? id,
    String? email,
    String? login,
    String? bio,
    String? username,
    String? avatar,
    List<String>? projectsIds,
  }) {
    return UserMockModel(
      id: id ?? this.id,
      email: email ?? this.email,
      login: login ?? this.login,
      bio: bio ?? this.bio,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      projectsIds: projectsIds ?? this.projectsIds,
    );
  }

  factory UserMockModel.mock() {
    return const UserMockModel(
      id: '1',
      email: 'test@mail.ru',
      login: 'test_log',
      bio: '@test_bio',
      username: 'test_user',
      avatar: '',
      projectsIds: ['1'],
    );
  }
}
