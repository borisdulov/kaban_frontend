import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/user/domain/entity/user_entity.dart';
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
      super(UserStateLoading()) {
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    emit(UserStateLoading());
    try {
      final currentUser = await _userRepository.getMe();
      emit(UserStateLoaded(users: [currentUser], currentUser: currentUser));
    } catch (e) {
      emit(UserStateFailed(error: e.toString()));
    }
  }

  Future<void> fetchUser(String id) async {
    if (!state.isLoaded) return;
    final currentState = state as UserStateLoaded;

    try {
      emit(UserStateLoading());
      final user = await _userRepository.getUser(id);

      final userExists = currentState.users.any((u) => u.id == id);
      final updatedUsers =
          userExists
              ? currentState.users.map((u) => u.id == id ? user : u).toList()
              : [...currentState.users, user];

      emit(currentState.copyWith(users: updatedUsers, selectedUser: user));
    } catch (e) {
      emit(UserStateFailed(error: e.toString()));
    }
  }

  Future<void> updateUser({
    String? email,
    String? username,
    String? bio,
    String? avatar,
  }) async {
    if (!state.isLoaded) return;
    final currentState = state as UserStateLoaded;

    try {
      emit(UserStateLoading());
      final updatedUser = await _userRepository.updateUser(
        email,
        username,
        bio,
        avatar,
      );

      final updatedUsers =
          currentState.users.map((u) {
            return u.id == updatedUser.id ? updatedUser : u;
          }).toList();

      emit(
        currentState.copyWith(
          users: updatedUsers,
          currentUser:
              currentState.currentUser?.id == updatedUser.id
                  ? updatedUser
                  : currentState.currentUser,
          selectedUser:
              currentState.selectedUser?.id == updatedUser.id
                  ? updatedUser
                  : currentState.selectedUser,
        ),
      );
    } catch (e) {
      emit(UserStateFailed(error: e.toString()));
    }
  }

  Future<void> searchUsersByUsername() async {
    if (!state.isLoaded) return;
    final currentState = state as UserStateLoaded;

    try {
      emit(UserStateLoading());
      final users = await _userRepository.getUsersByUsername();
      emit(currentState.copyWith(users: users));
    } catch (e) {
      emit(UserStateFailed(error: e.toString()));
    }
  }

  void selectUser(User user) {
    if (!state.isLoaded) return;
    final currentState = state as UserStateLoaded;

    emit(currentState.copyWith(selectedUser: user));
  }

  void clearSelectedUser() {
    if (!state.isLoaded) return;
    final currentState = state as UserStateLoaded;

    emit(currentState.copyWith(clearSelectedUser: true));
  }
}

typedef UserSelector<T> = BlocSelector<UserCubit, UserState, T>;
typedef UserListener = BlocListener<UserCubit, UserState>;
