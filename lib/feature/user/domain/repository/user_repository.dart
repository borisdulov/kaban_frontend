import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

abstract interface class UserRepository {
  Future<User> getUser(
    String id,
  ); //id

  Future<User> updateUser(
    String? email,
    String? username,
    String? bio,
    String? avatar,
  ); //username, avatar, bio, mail - nullable

  Future<User> getMe(); //вывод пользователя

  Future<List<User>> getUsersByUsername(); //вывод по имени всех юзеров
}
