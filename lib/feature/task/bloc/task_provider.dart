import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/bloc/config_bloc.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';
import 'package:kaban_frontend/feature/task/bloc/task_bloc.dart';

abstract final class TaskProvider {
  static BlocProvider<TaskCubit> get instance => BlocProvider(
    create: (context) {
      var repo = context.configCubit.resolve<TaskRepository>();
      return TaskCubit(taskRepository: repo);
    },
  );
}
