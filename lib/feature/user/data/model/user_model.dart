import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class UserAPIModel implements User {
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

  UserAPIModel({
    required this.id,
    this.email,
    required this.login,
    this.username,
    this.bio,
    this.avatar,
    this.projectsIds,
  });

  factory UserAPIModel.fromMap(Map<String, dynamic> map) {
    return UserAPIModel(
      id: map['id'] as String,
      email: map['email'] as String?,
      login: map['login'] as String,
      username: map['username'] as String?,
      bio: map['bio'] as String?,
      avatar: map['avatar'] as String?,
      projectsIds: List<String>.from(map['projectsIds']), //добавить нулабл
    );
  }
}
