import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/config_state.dart';
import 'package:kaban_frontend/core/di/di_container.dart';
import 'package:kaban_frontend/core/domain/dependency.dart';
import 'package:kaban_frontend/core/domain/env_type.dart';

extension ConfigExtension on BuildContext {
  ConfigBloc get configCubit => read<ConfigBloc>();
}

typedef ConfigBuilder = BlocBuilder<ConfigBloc, ConfigState>;

class ConfigBloc extends Cubit<ConfigState> {
  ConfigBloc(EnvType envType)
      : super(ConfigState(
            container: DIContainer(),
            status: ConfigStatus.loading,
            envType: envType)) {
    init();
  }

  Future<void> init() async {
    emit(state.copyWith(status: ConfigStatus.success));
  }

  T resolve<T extends Dependency>() => state.container.resolve<T>();
}
