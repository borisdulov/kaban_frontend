// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
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

  factory UserMockModel.random() {
    final random = Random();

    final id = random.nextInt(100000).toString();

    final includeEmail = random.nextBool();
    final email =
        includeEmail ? 'user${random.nextInt(1000)}@example.com' : null;

    final login = 'user${random.nextInt(1000)}';

    final includeBio = random.nextBool();
    final bios = [
      'Hello, I am a test user.',
      'This is a mock bio.',
      'Random bio for testing.',
    ];
    final bio = includeBio ? bios[random.nextInt(bios.length)] : null;

    final includeUsername = random.nextBool();
    final usernames = ['testuser', 'mockuser', 'randomuser'];
    final username =
        includeUsername ? usernames[random.nextInt(usernames.length)] : null;

    final includeAvatar = random.nextBool();
    final avatar =
        includeAvatar
            ? 'https://via.placeholder.com/150?text=User${random.nextInt(100)}'
            : null;

    final numProjects = random.nextInt(4);
    final projectsIds = List.generate(
      numProjects,
      (_) => random.nextInt(10000).toString(),
    );

    return UserMockModel(
      id: id,
      email: email,
      login: login,
      bio: bio,
      username: username,
      avatar: avatar,
      projectsIds: projectsIds,
    );
  }
}
