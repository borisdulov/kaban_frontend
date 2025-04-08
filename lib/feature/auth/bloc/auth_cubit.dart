import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:kaban_frontend/feature/auth/bloc/auth_cubit_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthCubitAuthorized());

  static AuthBloc i(BuildContext context) => context.read<AuthBloc>();
}
