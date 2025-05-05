import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';

class AddProjectCard extends StatelessWidget {
  const AddProjectCard({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 96,
      child: Card(
        color: context.colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.colorScheme.onSurface.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.r8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [IconButton(onPressed: onPressed, icon: Icon(Icons.add))],
        ),
      ),
    );
  }
}
