import 'package:kaban_frontend/core/domain/entity/dependency.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

abstract interface class TaskRepository implements Dependency {
  Future<Task> getTaskByColumnId(String columnId);
  Future<Task> getTask(String taskId);
  Future<Task> createTask(Task task);
  Future<Task> updateTask(Task task);
  Future<void> deleteTask(String taskId);
  Future<void> moveTaskToColumn(String taskId, String columnId);
  Future<List<Task>> getTasksByColumnId(String columnId);
}
