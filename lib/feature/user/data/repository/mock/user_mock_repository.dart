import 'package:kaban_frontend/feature/user/data/model/user_mock_model.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';
import 'package:kaban_frontend/feature/user/domain/repository/user_repository.dart';

class UserMockRepository implements UserRepository {
  UserMockModel _currentUser = UserMockModel.mock();

  @override
  Future<UserMockModel> getUser(String id) async {
    return _currentUser;
  }

  @override
  Future<UserMockModel> updateUser(
    String? email,
    String? username,
    String? bio,
    String? avatar,
  ) async {
    _currentUser = _currentUser.copyWith(
      email: email,
      username: 'new_name',
      bio: 'its new bio',
      avatar: '',
    );

    return _currentUser;
  }

  @override
  Future<UserMockModel> getMe() async {
    return _currentUser;
  }

  @override
  Future<List<UserMockModel>> getUsersByUsername() {
    // TODO: implement getUsersByUsername
    throw UnimplementedError();
  }

  @override
  Future<User> signUp(String login, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
