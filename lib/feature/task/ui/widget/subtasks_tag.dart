import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/task/ui/widget/tag_widget.dart';

class SubtasksTag extends StatelessWidget {
  const SubtasksTag({super.key});

  @override
  Widget build(BuildContext context) {
    return TagWidget(
      iconPath: AppAssets.list,
      //TODO сделать сабтаски
      text: '5/10',
      backgroundColor: context.colorScheme.surface,
      color: context.colorScheme.onSurface,
    );
  }
}
