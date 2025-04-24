import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.tertiaryFixedDim,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r16),
        side: BorderSide(color: context.colorScheme.onSurface.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.p12),
        child: Center(child: Text(text)),
      ),
    );
  }
}
