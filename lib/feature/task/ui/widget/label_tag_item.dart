import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';

class LabelTagItem extends StatelessWidget {
  const LabelTagItem({
    super.key,
    required this.iconPath,
    required this.text,
    this.color,
  });

  final String iconPath;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          color: context.colorScheme.onSurface,
        ),
        SizedBox(width: AppSize.p4),
        Text(text, style: context.textTheme.bodyMedium),
      ],
    );
  }
}
