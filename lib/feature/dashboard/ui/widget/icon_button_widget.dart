import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';

class IconButtonWidget extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;
  final double size;
  final Color? color;
  final Text? text;
  final bool showText;
  final MainAxisAlignment expandedAlignment;
  final MainAxisAlignment collapsedAlignment;

  const IconButtonWidget({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.size = 24,
    this.color,
    this.text,
    required this.showText,
    this.expandedAlignment = MainAxisAlignment.start,
    this.collapsedAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppRadius.r8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.p16,
          horizontal: AppSize.p4,
        ),
        child: Row(
          mainAxisAlignment: showText ? expandedAlignment : collapsedAlignment,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: SvgPicture.asset(
                assetPath,
                colorFilter:
                    color != null
                        ? ColorFilter.mode(color!, BlendMode.srcIn)
                        : null,
              ),
            ),
            if (showText && text != null)
              Padding(padding: EdgeInsets.only(left: AppSize.p8), child: text),
          ],
        ),
      ),
    );
  }
}
