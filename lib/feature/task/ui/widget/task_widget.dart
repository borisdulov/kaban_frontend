import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_bloc.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/ui/widget/date_tag.dart';
import 'package:kaban_frontend/feature/task/ui/widget/priority_tag.dart';
import 'package:kaban_frontend/feature/task/ui/widget/subtasks_tag.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  
  final Task task;

  @override
  Widget build(BuildContext context) {
    return AppFlowyGroupCard(
      key: ValueKey('${task.taskId}52'),
      margin: EdgeInsets.symmetric(vertical: AppSize.p8),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.r16),
        border: Border.all(
          color: context.colorScheme.onSurface.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: AppSize.p4),
                  child: Text(
                    task.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                  height: 32,
                  child: IconButton(
                    onPressed: () {
                      context.boardCubit.openEditPanel(task);
                    },
                    icon: Icon(
                      Icons.more_vert,
                      size: 16,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.p8),
            Row(
              children: [
                DateTag(date: task.dueDate),
                SizedBox(width: AppSize.p4), //возможно вынеси
                PriorityTag(priority: task.priority),
                SizedBox(width: AppSize.p4),
                SubtasksTag(),
              ],
            ),
            SizedBox(height: AppSize.p8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.avatarGroup),
                SizedBox(width: AppSize.p8),
                Text(
                  '+1',
                  style: GoogleFonts.roboto(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
