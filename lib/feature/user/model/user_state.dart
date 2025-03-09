import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';

abstract interface class UserState {
  bool get isLoading => this is UserStateLoading;
  bool get isLoaded => this is UserStateLoaded;
  bool get isFailed => this is UserStateFailed;
}

class UserStateLoading extends UserState {}

class UserStateFailed extends UserState {
  final String error;

  UserStateFailed({required this.error});
}

class UserStateLoaded extends UserState {
  final List<User> users;
  final User? currentUser;
  final User? selectedUser;

  UserStateLoaded({required this.users, this.currentUser, this.selectedUser});

  UserStateLoaded copyWith({
    List<User>? users,
    User? currentUser,
    User? selectedUser,
    bool clearSelectedUser = false,
  }) {
    return UserStateLoaded(
      users: users ?? this.users,
      currentUser: currentUser ?? this.currentUser,
      selectedUser:
          clearSelectedUser ? null : selectedUser ?? this.selectedUser,
    );
  }
}
