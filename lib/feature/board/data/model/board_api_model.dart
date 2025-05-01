import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
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
  final List<String> userIds;
  @override
  final List<User> users;
  @override
  final List<String> columnIds;
  @override
  final List<Column> columns;

  BoardAPIModel({
    required this.id,
    required this.title,
    required this.ownerId,
    this.owner,
    required this.userIds,
    this.users = const [],
    required this.columnIds,
    this.columns = const [],
  });

  factory BoardAPIModel.fromJSON(Map<String, dynamic> json) {
    return BoardAPIModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? json['name'] ?? 'Без названия',
      ownerId: json['ownerId'] ?? '',
      owner: null,
      userIds: List<String>.from(json['userIds'] ?? json['memberIds'] ?? []),
      columnIds: List<String>.from(json['columnIds'] ?? []),
    );
  }

  Map<String, dynamic> toJSON() {
    return {'title': title};
  }
}
