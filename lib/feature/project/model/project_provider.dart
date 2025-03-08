import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/config_bloc.dart';
import 'package:kaban_frontend/feature/project/domain/repository/project_repository.dart';
import 'package:kaban_frontend/feature/project/model/project_bloc.dart';

abstract final class ProjectProvider {
  static BlocProvider<ProjectCubit> get instance => BlocProvider(create: (context) {
        var repo = context.configCubit.resolve<ProjectRepository>();
        return ProjectCubit(projectRepository: repo);
      });
} 