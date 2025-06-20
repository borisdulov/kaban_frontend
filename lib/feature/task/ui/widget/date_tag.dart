import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/task/ui/widget/tag_widget.dart';

class DateTag extends StatelessWidget {
  const DateTag({super.key, this.date});

  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return TagWidget(
      iconPath: AppAssets.clock,
      text: date != null ? DateFormat('dd.MM').format(date!) : '--.--',
      backgroundColor: context.colorScheme.surface,
      color: context.colorScheme.onSurface,
    );
  }
}
