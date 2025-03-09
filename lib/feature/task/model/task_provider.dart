import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/config_bloc.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';
import 'package:kaban_frontend/feature/task/model/task_bloc.dart';

abstract final class TaskProvider {
  static BlocProvider<TaskCubit> get instance => BlocProvider(
    create: (context) {
      var repo = context.configCubit.resolve<TaskRepository>();
      return TaskCubit(taskRepository: repo);
    },
  );
}
