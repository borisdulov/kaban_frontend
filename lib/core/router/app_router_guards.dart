import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/feature/auth/bloc/auth_cubit.dart';
import 'package:kaban_frontend/feature/auth/bloc/auth_cubit_state.dart';

abstract final class AppRouterGuards {
  static FutureOr<String?> unauthorized(
    BuildContext context,
    GoRouterState state,
  ) {
    final authState = AuthBloc.i(context).state;

    if (authState is AuthCubitAuthorized) {
      return '/dashboard';
    }

    return null;
  }

  static FutureOr<String?> authorized(
    BuildContext context,
    GoRouterState state,
  ) {
    final authState = AuthBloc.i(context).state;

    if (authState is AuthCubitUnauthorized) {
      return '/auth/login';
    }

    if (authState is AuthCubitLoading) {
      return '/auth/loading';
    }

    return null;
  }

  static FutureOr<String?> public(BuildContext context, GoRouterState state) {
    return null;
  }
}
