import 'package:kaban_frontend/feature/column/domain/entity/column_entity.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

abstract interface class Board {
  String get id;
  String get title;

  String get ownerId;
  User? get owner;

  List<String> get userIds;
  List<User> get users;

  List<String> get columnIds;
  List<Column> get columns;
}
