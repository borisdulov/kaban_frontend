import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/env_type.dart';
import 'package:kaban_frontend/core/router/app_router.dart';
import 'package:kaban_frontend/core/config/bloc/config_provider.dart';
import 'package:kaban_frontend/core/theme/domain/cubit/theme_provider.dart';
import 'package:kaban_frontend/feature/auth/bloc/auth_cubit.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final envType = EnvType.fromEnv;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: ThemeProvider(
        child: ConfigProvider(
          envType: envType,
          child: MaterialApp.router(routerConfig: AppRouter.config),
        ),
      ),
    );
  }
}
