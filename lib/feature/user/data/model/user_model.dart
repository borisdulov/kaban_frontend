import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class UserAPIModel implements User {
  @override
  final String id;
  @override
  final String username;
  @override
  final List<String> boardIds;
  @override
  final List<Board> boards;

  final String login;

  UserAPIModel({
    required this.id,
    required this.login,
    this.username = '',
    this.boardIds = const [],
    this.boards = const [],
  });

  factory UserAPIModel.fromMap(Map<String, dynamic> map) {
    return UserAPIModel(
      id: map['_id'] ?? map['id'] ?? '',
      login: map['login'] ?? '',
      username: map['username'] ?? '',
      boardIds:
          map['boardIds'] != null ? List<String>.from(map['boardIds']) : [],
      boards: [],
    );
  }

  Map<String, dynamic> toJSON() {
    return {'username': username, 'login': login, 'boardIds': boardIds};
  }
}
