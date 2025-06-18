import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';

class UserState {
  final Status? status;
  final List<User> users;
  final String? error;

  const UserState({
    this.status = Status.initial,
    this.users = const [],
    this.error,
  });

  UserState copyWith({Status? status, List<User>? users, String? error}) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == Status.loading;
  bool get isLoaded => status == Status.success;
  bool get isFailed => status == Status.failure;
}
