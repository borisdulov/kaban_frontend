import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';

class TaskRepositoryMock implements TaskRepository {
  final List<Task> _tasks = [];
  int _idCounter = 1;

  TaskRepositoryMock() {
    _tasks.add(TaskMockModel.initialTask);
  }

  @override
  Future<void> assignTaskToUser(String taskId, String userId) async {
    final task = _tasks.firstWhere((t) => t.taskId == taskId);
    final updatedTask = TaskMockModel.copyWith(
      userIds: [...?task.userIds, userId],
      original: task,
    );
    _tasks[_tasks.indexOf(task)] = updatedTask;
  }

  @override
  Future<void> createSubtask(String taskId, Task subtask) async {
    final parentTask = _tasks.firstWhere((t) => t.taskId == taskId);
    final newSubtask = TaskMockModel.copyWith(
      taskId: (_idCounter++).toString(),
      projectId: parentTask.projectId,
      columnId: parentTask.columnId,
      original: subtask,
    );
    _tasks.add(newSubtask);

    final updatedParent = TaskMockModel.copyWith(
      subtaskIds: [...?parentTask.subtaskIds, newSubtask.taskId],
      original: parentTask,
    );
    _tasks[_tasks.indexOf(parentTask)] = updatedParent;
  }

  @override
  Future<Task> createTask(Task task) async {
    final newTask = TaskMockModel.copyWith(
      taskId: (_idCounter++).toString(),
      original: task,
    );
    _tasks.add(newTask);
    return newTask;
  }

  @override
  Future<void> delSubtask(String subtaskId) async {
    _tasks.removeWhere((t) => t.taskId == subtaskId);

    for (var task in _tasks) {
      if (task.subtaskIds?.contains(subtaskId) == true) {
        final updatedTask = TaskMockModel.copyWith(
          subtaskIds: task.subtaskIds?.where((id) => id != subtaskId).toList(),
          original: task,
        );
        _tasks[_tasks.indexOf(task)] = updatedTask;
      }
    }
  }

  @override
  Future<void> delTask(String taskId) async {
    _tasks.removeWhere((t) => t.taskId == taskId);
  }

  @override
  Future<List<Task>> filterTasks({
    List<String>? userIds,
    TaskPriority? priority,
    List<String>? tags,
    DateTime? dueDate,
    String? projectId,
  }) async {
    return _tasks.where((task) {
      bool matches = true;

      if (userIds != null) {
        matches = task.userIds?.any(userIds.contains) ?? false;
      }
      if (priority != null) {
        matches = matches && task.priority == priority;
      }
      if (tags != null) {
        matches = matches && (task.tags?.any(tags.contains) ?? false);
      }
      if (dueDate != null) {
        matches = matches && task.dueDate == dueDate;
      }
      if (projectId != null) {
        matches = matches && task.projectId == projectId;
      }

      return matches;
    }).toList();
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return _tasks.toList();
  }

  @override
  Future<Task> getTaskByProject(String projectId) async {
    return _tasks.firstWhere((t) => t.projectId == projectId);
  }

  @override
  Future<void> moveTaskToColumn(String taskId, String columnId) async {
    final task = _tasks.firstWhere((t) => t.taskId == taskId);
    final updatedTask =
        TaskMockModel.copyWith(columnId: columnId, original: task);
    _tasks[_tasks.indexOf(task)] = updatedTask;
  }

  @override
  Future<List<Task>> searchTasks() async {
    return _tasks.toList();
  }

  @override
  Future<void> setTaskDueDate(String taskId, DateTime dueDate) async {
    final task = _tasks.firstWhere((t) => t.taskId == taskId);
    final updatedTask =
        TaskMockModel.copyWith(dueDate: dueDate, original: task);
    _tasks[_tasks.indexOf(task)] = updatedTask;
  }

  @override
  Future<Task> updateTask(String taskId, Task task) async {
    final index = _tasks.indexWhere((t) => t.taskId == taskId);
    final updatedTask = TaskMockModel.copyWith(original: task);
    _tasks[index] = updatedTask;
    return updatedTask;
  }

  @override
  Future<void> updateTaskPriority(String taskId, TaskPriority priority) async {
    final task = _tasks.firstWhere((t) => t.taskId == taskId);
    final updatedTask =
        TaskMockModel.copyWith(priority: priority, original: task);
    _tasks[_tasks.indexOf(task)] = updatedTask;
  }

  @override
  Future<void> updateTaskTags(String taskId, List<String> tags) async {
    final task = _tasks.firstWhere((t) => t.taskId == taskId);
    final updatedTask = TaskMockModel.copyWith(tags: tags, original: task);
    _tasks[_tasks.indexOf(task)] = updatedTask;
  }
}
