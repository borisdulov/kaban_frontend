// task_mock_model.dart
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';

class TaskMockModel {
  static TaskAPIModel get initialTask => TaskAPIModel(
        taskId: '1',
        title: 'Initial Task',
        projectId: 'project1',
        columnId: 'column1',
        userIds: [],
        isCompleted: false,
        priority: TaskPriority.normal,
        subtaskIds: [],
        tags: [],
        subtasks: [],
      );

  static Task copyWith({
    String? taskId,
    String? title,
    String? description,
    List<String>? subtasks,
    List<String>? tags,
    String? projectId,
    String? columnId,
    List<String>? subtaskIds,
    List<String>? userIds,
    bool? isCompleted,
    TaskPriority? priority,
    DateTime? dueDate,
    required Task original,
  }) {
    return TaskAPIModel(
      taskId: taskId ?? original.taskId,
      title: title ?? original.title,
      description: description ?? original.description,
      subtasks: subtasks ?? original.subtasks,
      tags: tags ?? original.tags,
      projectId: projectId ?? original.projectId,
      columnId: columnId ?? original.columnId,
      subtaskIds: subtaskIds ?? original.subtaskIds,
      userIds: userIds ?? original.userIds,
      isCompleted: isCompleted ?? original.isCompleted,
      priority: priority ?? original.priority,
      dueDate: dueDate ?? original.dueDate,
    );
  }
}