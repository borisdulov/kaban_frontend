import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/config_bloc.dart';
import 'package:kaban_frontend/core/domain/env_type.dart';

class ConfigProvider extends StatelessWidget {
  final Widget child;
  final EnvType envType;

  const ConfigProvider({super.key, required this.child, required this.envType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfigBloc>(
      create: (_) => ConfigBloc(envType),
      child: child,
    );
  }
}
