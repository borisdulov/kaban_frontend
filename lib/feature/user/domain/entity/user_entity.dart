import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';

abstract interface class User {
  String get id;
  String get username;

  List<String> get boardIds;
  List<Board> get boards;
}
