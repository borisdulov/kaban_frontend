import 'package:kaban_frontend/core/domain/entity/dependency.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';

abstract interface class TaskRepository implements Dependency {
  Future<List<Task>> getAllTasks();

  Future<Task> getTaskByCategoryId(String categoryId);

  Future<Task> getTask(String taskId);

  Future<Task> createTask(Task task);

  Future<Task> updateTask(Task task);

  Future<void> deleteTask(String taskId);

  Future<void> moveTaskToCategory(String taskId, String categoryId);

  Future<void> giveTask(String userId, String taskId);

  Future<List<Task>> searchTasks();

  Future<List<Task>> filterTasks({
    List<String>? userIds,
    TaskPriority? priority,
    List<String>? tags,
    DateTime? dueDate,
    String? projectId,
  });
}
