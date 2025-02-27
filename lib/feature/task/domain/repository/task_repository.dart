import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';

abstract interface class TaskRepository {
  Future<List<Task>> getAllTasks();

  Future<Task> getTaskByProject(String projectId);

  Future<Task> createTask(Task task);

  Future<Task> updateTask(String taskId, Task task);

  Future<void> delTask(String taskId);

  Future<void> moveTaskToColumn(String taskId, String columnIds);

  Future<void> createSubtask(String taskId, Task subtasks);

  Future<void> delSubtask(String subtaskIds);

  Future<void> updateTaskTags(String taskId, List<String> tags);

  Future<void> assignTaskToUser(String taskId, String userId);

  Future<void> setTaskDueDate(String taskId, DateTime dueDate);

  Future<List<Task>> searchTasks(); //нереализовано

  Future<List<Task>> filterTasks({
    List<String>? userIds,
    TaskPriority? priority,
    List<String>? tags,
    DateTime? dueDate,
    String? projectId,
  });

  Future<void> updateTaskPriority(String taskId, TaskPriority priority);
}
