import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class UserModel implements User {
  @override
  final String id;
  @override
  final String email;
  @override
  final String username;
  @override
  final String avatar;
  @override
  final List<String> teamsIds;
  /** @override
  final List<Team> teams; */
  @override
  final List<String> projectsIds;
  /** @override
  final List<Project> projects; */

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.avatar,
    required this.teamsIds,
    required this.projectsIds,
    /** required this.teams,
    required this.projects */

  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      avatar: map['avatar'] as String,
      teamsIds: List<String>.from(map['teamsIds']),
      projectsIds: List<String>.from(map['projectsIds']),
      /** teams: map['teams'] ?? [],
       *  projects: map['projects'] ?? [],
       */
    );
  }
}
