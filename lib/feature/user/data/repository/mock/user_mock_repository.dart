import 'package:kaban_frontend/feature/user/data/model/user_model.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';
import 'package:kaban_frontend/feature/user/domain/repository/user_repository.dart';

class UserMockRepository implements UserRepository {
  @override
  Future<User> getUser() async {
    final User user = UserAPIModel(
      id: '1',
      email: 'test@mail.ru',
      login: 'test_login',
      username: 'test_user',
      bio: '@test',
      avatar: '',
      projectsIds: ['1'],
    );
    return user;
  }
}
