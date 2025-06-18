import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/bloc/config_bloc.dart';
import 'package:kaban_frontend/feature/user/domain/repository/user_repository.dart';
import 'package:kaban_frontend/feature/user/bloc/user_bloc.dart';

abstract final class UserProvider {
  static BlocProvider<UserCubit> get instance => BlocProvider(
    create: (context) {
      var repo = context.configCubit.get<UserRepository>();
      return UserCubit(userRepository: repo);
    },
  );
}
