import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/router/app_router.dart';
import 'package:kaban_frontend/feature/config/bloc/config_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfigProvider(
      child: MaterialApp.router(
        routerConfig: AppRouter.config,
      ),
    );
  }
}
