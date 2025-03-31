import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWidget extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;
  final double size;
  final Color? color;

  const IconButtonWidget({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.size = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          assetPath,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
