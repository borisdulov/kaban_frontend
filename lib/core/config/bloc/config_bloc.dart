import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/bloc/config_state.dart';
import 'package:kaban_frontend/core/config/model/di_container.dart';
import 'package:kaban_frontend/core/domain/entity/dependency.dart';
import 'package:kaban_frontend/core/domain/entity/env_type.dart';
import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/board/data/repository/project_repository_mock_impl.dart';
import 'package:kaban_frontend/feature/board/domain/repository/project_repository.dart';

extension ConfigExtension on BuildContext {
  ConfigBloc get configCubit => read<ConfigBloc>();
}

typedef ConfigBuilder = BlocBuilder<ConfigBloc, ConfigState>;

class ConfigBloc extends Cubit<ConfigState> {
  ConfigBloc(EnvType envType)
    : super(
        ConfigState(
          container: DIContainer(),
          status: ConfigStatus.loading,
          envType: envType,
        ),
      ) {
    init();
  }

  Future<void> init() async {
    put<ProjectRepository>(ProjectRepositoryMockImpl());
    put<ApiClient>(ApiClient(hostUrl: 'localhost:3000/'));

    emit(state.copyWith(status: ConfigStatus.success));
  }

  T get<T extends Dependency>() => state.container.get<T>();
  T put<T extends Dependency>(T dep) => state.container.put<T>(dep);
}
