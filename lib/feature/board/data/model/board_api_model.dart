import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/column/data/model/column_api_model.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/user/data/model/user_model.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

class BoardAPIModel implements Board {
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

  BoardAPIModel({
    required this.id,
    required this.title,
    required this.ownerId,
    this.owner,
    required this.usersId,
    this.users = const [],
    required this.columnsId,
    this.columns = const [],
  });

  factory BoardAPIModel.fromJSON(Map<String, dynamic> json) {
    final users =
        (json['users'] as List<dynamic>? ?? [])
            .map((e) => UserAPIModel.fromMap(e as Map<String, dynamic>))
            .toList();

    final columns =
        (json['columns'] as List<dynamic>? ?? [])
            .map((e) => ColumnAPIModel.fromJSON(e as Map<String, dynamic>))
            .toList();

    return BoardAPIModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? json['name'] ?? 'Без названия',
      ownerId: json['ownerId'] ?? '',
      owner: null,
      usersId: List<String>.from(json['usersId'] ?? []),
      columnsId: List<String>.from(json['columnsId'] ?? []),
      columns: columns,
      users: users,
    );
  }

  Map<String, dynamic> toJSON() {
    return {'title': title};
  }
}
