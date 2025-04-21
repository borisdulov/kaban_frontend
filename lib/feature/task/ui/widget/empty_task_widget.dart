import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.edit, size: AppSize.p16),
        SizedBox(width: AppSize.p8),
        Text('Type a task text...'),
      ],
    );
  }
}
