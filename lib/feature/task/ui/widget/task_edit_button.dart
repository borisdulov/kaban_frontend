import 'package:flutter/material.dart';

class TaskEditButton extends StatelessWidget {
  const TaskEditButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}
