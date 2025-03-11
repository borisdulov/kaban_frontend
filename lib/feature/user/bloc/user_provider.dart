import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/config_bloc.dart';
import 'package:kaban_frontend/feature/user/domain/repository/user_repository.dart';
import 'package:kaban_frontend/feature/user/bloc/user_bloc.dart';

abstract final class UserProvider {
  static BlocProvider<UserCubit> get instance => BlocProvider(
    create: (context) {
      var repo = context.configCubit.resolve<UserRepository>();
      return UserCubit(userRepository: repo);
    },
  );
}
