import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/ui/widget/tag_widget.dart';

class PriorityTag extends StatelessWidget {
  const PriorityTag({super.key, required this.priority});

  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TagWidget(
      iconPath: AppAssets.barChart,
      text: priority.str,
      backgroundColor: colorScheme.error,
      color: colorScheme.onSurface,
    );
  }
}
