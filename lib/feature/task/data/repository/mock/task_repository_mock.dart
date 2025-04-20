import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';

class TaskRepositoryMock implements TaskRepository {
  final List<TaskMockModel> _tasks = [];
  int _idCounter = 1;

  TaskRepositoryMock() {
    _tasks.add(TaskMockModel.mock());
  }

  @override
  Future<List<Task>> getAllTasks() async => _tasks.toList();

  @override
  Future<Task> getTaskByCategoryId(String categoryId) async {
    return _tasks.firstWhere((t) => t.categoryId == categoryId);
  }

  @override
  Future<Task> createTask(Task task) async {
    final newTask = TaskMockModel(
      taskId: (_idCounter++).toString(),
      title: task.title,
      categoryId: task.categoryId,
      isCompleted: task.isCompleted,
      priority: task.priority,
      createdAt: task.createdAt,
    );
    _tasks.add(newTask);
    return newTask;
  }

  @override
  Future<Task> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.taskId == task.taskId);

    final updatedTask = _tasks[index].copyWith(
      title: task.title,
      description: task.description,
      tagId: task.tagId,
      categoryId: task.categoryId,
      categoryList: task.categoryList,
      userIds: task.userIds,
      userList: task.userList,
      isCompleted: task.isCompleted,
      priority: task.priority,
      dueDate: task.dueDate,
    );

    _tasks[index] = updatedTask;
    return updatedTask;
  }

  @override
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((t) => t.tagId == taskId);
  }

  @override
  Future<void> moveTaskToCategory(String taskId, String categoryId) async {
    final index = _tasks.indexWhere((t) => t.taskId == taskId);

    _tasks[index] = _tasks[index].copyWith(
      categoryId: categoryId,
      categoryList: [...?_tasks[index].categoryList, categoryId],
    );
  }

  @override
  Future<List<Task>> searchTasks() async {
    return _tasks.toList();
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
        matches = matches && (task.tagId != null && tags.contains(task.tagId));
      }
      if (dueDate != null) {
        matches = matches && task.dueDate!.isAtSameMomentAs(dueDate);
      }
      if (projectId != null) {
        // Предполагаем, что projectId связан с категорией
        matches = matches && task.categoryId == projectId;
      }

      return matches;
    }).toList();
  }

  @override
  Future<Task> getTask(String taskId) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<void> giveTask(String userId, String taskId) {
    // TODO: implement giveTask
    throw UnimplementedError();
  }
}
