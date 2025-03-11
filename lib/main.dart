import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/domain/env_type.dart';
import 'package:kaban_frontend/core/router/app_router.dart';
import 'package:kaban_frontend/core/config/bloc/config_provider.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final envType = EnvType.fromEnv;

  @override
  Widget build(BuildContext context) {
    return ConfigProvider(
      envType: envType,
      child: MaterialApp.router(routerConfig: AppRouter.config),
    );
  }
}
