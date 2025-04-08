import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/bloc/config_bloc.dart';
import 'package:kaban_frontend/feature/board/domain/repository/project_repository.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/project_list_bloc.dart';

abstract final class ProjectListProvider {
  static BlocProvider<ProjectListCubit> get instance => BlocProvider(
    create: (context) {
      var repo = context.configCubit.get<ProjectRepository>();
      return ProjectListCubit(projectRepository: repo);
    },
  );
}
