import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWidget extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;
  final double size;

  const IconButtonWidget({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(assetPath),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
