import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_bloc.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/ui/widget/add_tag_button.dart';
import 'package:kaban_frontend/feature/task/ui/widget/label_tag_item.dart';

class TaskEditPage extends StatelessWidget {
  const TaskEditPage({super.key, required this.task});

  final Task task;
  static const String name = '/TaskEdit';
  static const String path = '/taskEdit';

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController(
      text: task.title,
    );
    final TextEditingController _descriptionController = TextEditingController(
      text: task.description,
    );

    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
          maxWidth: 400,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border(
            left: BorderSide(
              color: context.colorScheme.onSurface.withOpacity(0.2),
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSize.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.p12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          controller: _titleController,
                          style: context.textTheme.titleLarge,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: 'Type a task text...',
                            contentPadding: EdgeInsets.zero,
                          ),
                          onSubmitted: (value) {
                            _updateTask(context, value);
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _updateTask(context, _titleController.text);
                          _updateTaskDescription(
                            context,
                            _descriptionController.text,
                          );
                          context.boardCubit.closeEditPanel();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSize.p32),
                IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.p12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabelTagItem(
                              iconPath: AppAssets.accountCircle,
                              text: 'User',
                            ),
                            SizedBox(height: AppSize.p24),
                            LabelTagItem(
                              iconPath: AppAssets.clock,
                              text: 'Date',
                            ),
                            SizedBox(height: AppSize.p24),
                            LabelTagItem(
                              iconPath: AppAssets.barChart,
                              text: 'Priority',
                            ),
                          ],
                        ),
                        SizedBox(width: AppSize.p24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AddTagButton(text: 'Assign', onPressed: () {}),
                            SizedBox(height: AppSize.p24),
                            AddTagButton(text: 'Select date', onPressed: () {}),
                            SizedBox(height: AppSize.p24),
                            AddTagButton(text: 'Choose', onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSize.p32),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSize.p12,
                      ),
                      child: Text('Description'),
                    ),
                    SizedBox(height: AppSize.p8),
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r8),
                          side: BorderSide(
                            color: context.colorScheme.onSurface.withOpacity(
                              0.2,
                            ),
                          ),
                        ),
                        color: context.colorScheme.surface,
                        child: Padding(
                          padding: EdgeInsets.all(AppSize.p12),
                          child: FocusScope(
                            child: TextField(
                              controller: _descriptionController,
                              maxLines: 5,
                              expands: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'What is this task about?',
                                hintStyle: TextStyle(
                                  color: context.colorScheme.onSurface
                                      .withOpacity(0.4),
                                ),
                              ),
                              onSubmitted: (value) {
                                _updateTaskDescription(context, value);
                                context.boardCubit.closeEditPanel();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSize.p8),
                    TextButton(
                      onPressed: () {
                        final updatedTask = _createUpdatedTask(
                          task,
                          title: _titleController.text.trim(),
                          description: _descriptionController.text,
                        );

                        if (updatedTask.title.isNotEmpty) {
                          context.boardCubit.updateTask(updatedTask);
                          debugPrint(
                            'Updating task: ${updatedTask.id} with title: ${updatedTask.title} and description: ${updatedTask.description}',
                          );
                          context.boardCubit.closeEditPanel();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.green),
                        foregroundColor: WidgetStateProperty.all(
                          context.colorScheme.onSurface,
                        ),
                      ),
                      child: Text('Save Changes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateTask(BuildContext context, String newTitle) {
    if (newTitle.trim().isNotEmpty) {
      final updatedTask = _createUpdatedTask(task, title: newTitle.trim());
      context.boardCubit.updateTask(updatedTask);
    }
  }

  void _updateTaskDescription(BuildContext context, String newDescription) {
    final updatedTask = _createUpdatedTask(task, description: newDescription);
    context.boardCubit.updateTask(updatedTask);
  }

  Task _createUpdatedTask(Task task, {String? title, String? description}) {
    if (task is TaskMockModel) {
      return task.copyWith(title: title, description: description);
    } else if (task is TaskAPIModel) {
      return TaskAPIModel(
        id: task.id,
        title: title ?? task.title,
        description: description ?? task.description,
        columnId: task.columnId,
        userIds: task.userIds,
        creatorId: task.creatorId,
        creator: task.creator,
        priority: task.priority,
        dueDate: task.dueDate,
        isCompleted: task.isCompleted,
        users: task.users,
        column: task.column,
      );
    }
    throw UnsupportedError('Unsupported Task type');
  }
}
