import 'dart:math';
import 'package:kaban_frontend/feature/column/data/model/column_mock_model.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/user/data/model/user_mock_model.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class BoardMockModel implements Board {
  @override
  final String id;
  @override
  final String title;
  @override
  final String ownerId;
  @override
  final User? owner;
  @override
  final List<String> usersId;
  @override
  final List<User> users;
  @override
  final List<String> columnsId;
  @override
  final List<Column> columns;

  BoardMockModel({
    required this.id,
    required this.title,
    required this.ownerId,
    this.owner,
    required this.usersId,
    this.users = const [],
    required this.columnsId,
    this.columns = const [],
  });

  BoardMockModel copyWith({
    String? id,
    String? title,
    String? ownerId,
    User? owner,
    List<String>? userIds,
    List<User>? users,
    List<String>? columnIds,
    List<Column>? columns,
  }) {
    return BoardMockModel(
      id: id ?? this.id,
      title: title ?? this.title,
      ownerId: ownerId ?? this.ownerId,
      owner: owner ?? this.owner,
      usersId: userIds ?? this.usersId,
      users: users ?? this.users,
      columnsId: columnIds ?? this.columnsId,
      columns: columns ?? this.columns,
    );
  }

  factory BoardMockModel.random() {
    final random = Random();

    final id = random.nextInt(100000).toString();

    final title =
        ['Board Alpha', 'Board Beta', 'Board Gamma', 'Board Delta'][random
            .nextInt(4)];

    final owner = UserMockModel.random();
    final ownerId = owner.id;

    final numMembers = random.nextInt(5);
    final users = List.generate(numMembers, (_) => UserMockModel.random());
    final userIds = users.map((user) => user.id).toList();

    final numColumns = random.nextInt(5);
    final columns = List.generate(
      numColumns,
      (_) => ColumnMockModel.random().copyWith(boardId: id),
    );
    final columnIds = columns.map((column) => column.id).toList();

    return BoardMockModel(
      id: id,
      title: title,
      ownerId: ownerId,
      owner: owner,
      usersId: userIds,
      users: users,
      columnsId: columnIds,
      columns: columns,
    );
  }
}
