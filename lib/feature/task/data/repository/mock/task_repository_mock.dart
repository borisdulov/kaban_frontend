import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/repository/task_repository.dart';
import 'package:kaban_frontend/feature/user/data/model/user_mock_model.dart';

class TaskRepositoryMock implements TaskRepository {
  final List<TaskMockModel> _tasks = [];
  int _idCounter = 1;

  TaskRepositoryMock() {
    _tasks.add(TaskMockModel.mock());
  }

  @override
  Future<Task> getTaskByColumnId(String columnId) async {
    return _tasks.firstWhere((t) => t.columnId == columnId);
  }

  @override
  Future<List<Task>> getTasksByColumnId(String columnId) async {
    return _tasks.where((task) => task.columnId == columnId).toList();
  }

  @override
  Future<Task> createTask(Task task) async {
    final creator = UserMockModel.mock();

    final newTask = TaskMockModel(
      id: (_idCounter++).toString(),
      title: task.title,
      description: task.description,
      columnId: task.columnId,
      userIds: task.userIds,
      creatorId: creator.id,
      creator: creator,
      priority: task.priority,
      dueDate: task.dueDate,
    );
    _tasks.add(newTask);
    return newTask;
  }

  @override
  Future<Task> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);

    final updatedTask = _tasks[index].copyWith(
      title: task.title,
      description: task.description,
      columnId: task.columnId,
      userIds: task.userIds,
      priority: task.priority,
      dueDate: task.dueDate,
    );

    _tasks[index] = updatedTask;
    return updatedTask;
  }

  @override
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((t) => t.id == taskId);
  }

  @override
  Future<void> moveTaskToColumn(String taskId, String columnId) async {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(columnId: columnId);
    }
  }

  @override
  Future<Task> getTask(String taskId) async {
    return _tasks.firstWhere((t) => t.id == taskId);
  }
}
