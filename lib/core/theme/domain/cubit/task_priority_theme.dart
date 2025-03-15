import 'dart:ui';

import 'package:kaban_frontend/core/constants/app_colors.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';

class TaskPriorityTheme {
  const TaskPriorityTheme._();

 static Color backgroundColor(TaskPriority priority) {
  switch (priority) {
    case TaskPriority.high:
      return AppColors.priorityHigh.withOpacity(0.2);
    case TaskPriority.major:
      return AppColors.priorityMajor.withOpacity(0.2);
    case TaskPriority.medium:
      return AppColors.priorityMedium.withOpacity(0.2);
    case TaskPriority.low:
      return AppColors.priorityLow.withOpacity(0.2);
  }
 } 
}