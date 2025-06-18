// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class UserMockModel implements User {
  @override
  final String id;
  @override
  final String username;
  @override
  final List<String> boardIds;
  @override
  final List<Board> boards;

  final String login;

  const UserMockModel({
    required this.id,
    required this.username,
    required this.login,
    this.boardIds = const [],
    this.boards = const [],
  });

  UserMockModel copyWith({
    String? id,
    String? username,
    String? login,
    String? email,
    String? bio,
    String? avatar,
    List<String>? boardIds,
    List<Board>? boards,
  }) {
    return UserMockModel(
      id: id ?? this.id,
      username: username ?? this.username,
      login: login ?? this.login,
      boardIds: boardIds ?? this.boardIds,
      boards: boards ?? this.boards,
    );
  }

  factory UserMockModel.mock() {
    const String validObjectId = '507f1f77bcf86cd799439011';

    return const UserMockModel(
      id: validObjectId,
      username: 'test_user',
      login: 'test_log',
      boardIds: ['507f1f77bcf86cd799439012'],
    );
  }

  factory UserMockModel.random() {
    String generateObjectId() {
      final random = Random();
      final buffer = StringBuffer();
      for (var i = 0; i < 24; i++) {
        buffer.write(random.nextInt(16).toRadixString(16));
      }
      return buffer.toString();
    }

    final id = generateObjectId();
    final login = 'user${Random().nextInt(1000)}';
    final username = 'user_${Random().nextInt(1000)}';

    final numBoards = Random().nextInt(4);
    final boardIds = List.generate(numBoards, (_) => generateObjectId());

    return UserMockModel(
      id: id,
      username: username,
      login: login,
      boardIds: boardIds,
    );
  }
}
