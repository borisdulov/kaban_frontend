import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

abstract interface class UserRepository {
  Future<User> getUser();
}