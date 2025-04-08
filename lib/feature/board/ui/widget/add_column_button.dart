import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/core/theme/data/entity/app_theme_size.dart';
import 'package:smooth_corner/smooth_corner.dart';

class AddColumnButton extends StatelessWidget {
  const AddColumnButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SmoothCard(
      elevation: 0,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      color: context.colorScheme.surfaceContainerLow,
      child: SizedBox(
        height: AppThemeSize.p40,
        child: IconButton(
          style: IconButton.styleFrom(
            foregroundColor: context.colorScheme.onSurfaceVariant,
          ),
          onPressed: onPressed,
          icon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppThemeSize.p8),
            child: Row(
              children: [
                Icon(Icons.add, size: 20),
                SizedBox(width: AppThemeSize.p4),
                Text('Add Column', style: context.textTheme.labelLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
