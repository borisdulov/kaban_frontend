import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/user/data/model/user_model.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';
import 'package:kaban_frontend/feature/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient _apiClient;

  UserRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<User> getMe() async {
    final response = await _apiClient.get('/user/me');
    return UserAPIModel.fromMap(response.data);
  }

  @override
  Future<User> getUser(String id) async {
    final response = await _apiClient.get('/user/$id');
    return UserAPIModel.fromMap(response.data);
  }

  @override
  Future<List<User>> getUsersByUsername() async {
    final response = await _apiClient.get('/user/search');
    final List<dynamic> data = response.data;
    return data.map((json) => UserAPIModel.fromMap(json)).toList();
  }

  @override
  Future<User> updateUser(String? username) async {
    final Map<String, dynamic> data = {};

    if (username != null) {
      data['username'] = username;
    }

    final response = await _apiClient.post('/user/update', data: data);
    return UserAPIModel.fromMap(response.data);
  }

  @override
  Future<User> signUp(String login, String password) async {
    final response = await _apiClient.post(
      '/user/sign-up',
      data: {'username': login, 'password': password},
    );
    return UserAPIModel.fromMap(response.data);
  }
}
