import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/bloc/config_state.dart';
import 'package:kaban_frontend/core/config/model/di_container.dart';
import 'package:kaban_frontend/core/domain/entity/dependency.dart';
import 'package:kaban_frontend/core/domain/entity/env_type.dart';
import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/board/data/repository/board_repository_api_impl.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';
import 'package:kaban_frontend/feature/column/data/repository/column_repository_api_impl.dart';
import 'package:kaban_frontend/feature/column/domain/repository/column_repository.dart';
import 'package:kaban_frontend/feature/task/data/repository/task_repository_impl.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';
import 'package:kaban_frontend/feature/user/data/repository/user_repository_impl.dart';
import 'package:kaban_frontend/feature/user/domain/repository/user_repository.dart';

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
          useMocks: false,
        ),
      ) {
    init();
  }

  void toggleMocks(bool value) {
    emit(state.copyWith(useMocks: value));
  }

  Future<void> init() async {
    final ApiClient apiClient = ApiClient(hostUrl: 'http://localhost:3000');

    final BoardRepository boardRepository = BoardRepositoryImpl(
      apiClient: apiClient,
    );

    final TaskRepository taskRepository = TaskRepositoryImpl(
      apiClient: apiClient,
    );

    final ColumnRepository columnRepository = ColumnRepositoryApiImpl(
      apiClient: apiClient,
    );

    final UserRepository userRepository = UserRepositoryImpl(
      apiClient: apiClient,
    );

    put<ApiClient>(apiClient);
    put<BoardRepository>(boardRepository);
    put<TaskRepository>(taskRepository);
    put<ColumnRepository>(columnRepository);
    put<UserRepository>(userRepository);

    emit(state.copyWith(status: ConfigStatus.success));
  }

  T get<T extends Dependency>() => state.container.get<T>();
  T put<T extends Dependency>(T dep) => state.container.put<T>(dep);
}
