import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/config/bloc/config_state.dart';
import 'package:kaban_frontend/feature/config/domain/env_type.dart';

final class ConfigBloc extends Cubit<ConfigState> {
  ConfigBloc() : super(ConfigStateLoading()) {
    init();
  }

  void init() {
    final envTypeString =
        String.fromEnvironment('ENV_TYPE', defaultValue: 'dev');
    final envType = EnvType.fromString(envTypeString);
    emit(ConfigStateSuccess(envType: envType));
  }
}
