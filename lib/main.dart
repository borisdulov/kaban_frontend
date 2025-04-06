import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/env_type.dart';
import 'package:kaban_frontend/core/router/app_router.dart';
import 'package:kaban_frontend/core/config/bloc/config_provider.dart';
import 'package:kaban_frontend/core/theme/cubit/theme_bloc.dart';
import 'package:kaban_frontend/core/theme/cubit/theme_state.dart';
import 'package:kaban_frontend/feature/project/bloc/project_list/project_list_bloc.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final envType = EnvType.fromEnv;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ThemeBloc.provider(),
        ProjectListCubit.provider(projectId: '1'),
      ],
      child: ConfigProvider(
        envType: envType,
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: AppRouter.config,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: state.themeMode,
              themeAnimationDuration: Duration.zero,
            );
          },
        ),
      ),
    );
  }
}
