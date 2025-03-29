import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:kaban_frontend/feature/auth/bloc/auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitAuthorized());

  static AuthCubit i(BuildContext context) => context.read<AuthCubit>();
}
