import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';
import 'package:kaban_frontend/feature/task/bloc/task_edit/task_edit_state.dart';

class TaskEditBloc extends Cubit<TaskEditState> {
  final TaskRepository taskRepository;

  TaskEditBloc({required this.taskRepository}) : super(TaskEditState());

  Future<void> loadTask(String taskId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final task = await taskRepository.getTask(taskId);
      emit(state.copyWith(task: task, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> updateTask(Task task) async {
    emit(state.copyWith(isLoading: true));
    try {
      final updatedTask = await taskRepository.updateTask(task);
      emit(state.copyWith(task: updatedTask, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
