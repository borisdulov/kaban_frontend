import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/user/domain/repository/user_repository.dart';
import 'package:kaban_frontend/feature/user/model/user_state.dart';

extension UserExtension on BuildContext {
  UserCubit get userCubit => read<UserCubit>();
}

typedef UserBuilder = BlocBuilder<UserCubit, UserState>;

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const UserState(status: Status.loading)) {
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final currentUser = await _userRepository.getMe();
      emit(UserState(status: Status.success, users: [currentUser]));
    } catch (e) {
      emit(UserState(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> fetchUser(String id) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final user = await _userRepository.getUser(id);

      final userExists = state.users.any((u) => u.id == id);
      final updatedUsers =
          userExists
              ? state.users.map((u) => u.id == id ? user : u).toList()
              : [...state.users, user];

      emit(state.copyWith(status: Status.success, users: updatedUsers));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> updateUser({
    String? email,
    String? username,
    String? bio,
    String? avatar,
  }) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final updatedUser = await _userRepository.updateUser(
        email,
        username,
        bio,
        avatar,
      );

      final updatedUsers =
          state.users.map((u) {
            return u.id == updatedUser.id ? updatedUser : u;
          }).toList();

      emit(state.copyWith(status: Status.success, users: updatedUsers));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> searchUsersByUsername() async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final users = await _userRepository.getUsersByUsername();
      emit(state.copyWith(status: Status.success, users: users));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}

typedef UserSelector<T> = BlocSelector<UserCubit, UserState, T>;
typedef UserListener = BlocListener<UserCubit, UserState>;
