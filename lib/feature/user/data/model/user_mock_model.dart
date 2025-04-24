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
    return const UserMockModel(
      id: '1',
      username: 'test_user',
      login: 'test_log',
      boardIds: ['1'],
    );
  }

  factory UserMockModel.random() {
    final random = Random();

    final id = random.nextInt(100000).toString();

    final login = 'user${random.nextInt(1000)}';

    final username = 'user_${random.nextInt(1000)}';

    final numBoards = random.nextInt(4);
    final boardIds = List.generate(
      numBoards,
      (_) => random.nextInt(10000).toString(),
    );

    return UserMockModel(
      id: id,
      username: username,
      login: login,
      boardIds: boardIds,
    );
  }
}
