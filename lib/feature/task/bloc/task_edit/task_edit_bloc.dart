import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';

class TaskEditBloc extends Cubit<void> {
  final TaskRepository taskRepository;

  TaskEditBloc({required this.taskRepository}) : super(null);

  Future<void> loadTask(String taskId) async {
    await taskRepository.getTask(taskId);
  }

  Future<void> updateTask(Task task) async {
    await taskRepository.updateTask(task);
  }
}
