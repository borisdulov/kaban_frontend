import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/config/bloc/config_bloc.dart';

class ConfigProvider extends StatelessWidget {
  final Widget child;

  const ConfigProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfigBloc>(
      create: (_) => ConfigBloc(),
      child: child,
    );
  }
}
