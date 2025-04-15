import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_bloc.dart';
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
    return Material(
      elevation: 16,
      child: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
          maxWidth: 320,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          border: Border(left: BorderSide(color: Colors.grey.shade300)),
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
                      Text(task.title, style: context.textTheme.titleLarge),
                      IconButton(
                        onPressed: () {
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
                            // SizedBox(height: AppSize.p4),
                            LabelTagItem(
                              iconPath: AppAssets.list,
                              text: 'Subtask',
                            ),
                            SizedBox(height: AppSize.p24),
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
                        //2
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AddTagButton(text: 'Subtask', onPressed: () {}),
                            SizedBox(height: AppSize.p24),
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
                          child: Text(
                            'Whats is this task about?',
                            style: TextStyle(
                              color: context.colorScheme.onSurface.withOpacity(
                                0.4,
                              ),
                            ),
                          ),
                        ),
                      ),
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
}
