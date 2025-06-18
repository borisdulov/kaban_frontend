import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';

class AddTagButton extends StatelessWidget {
  const AddTagButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(color: context.colorScheme.onSurface.withOpacity(0.4)),
      ),
    );
  }
}
