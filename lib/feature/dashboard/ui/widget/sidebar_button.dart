import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SidebarButton extends StatelessWidget {
  const SidebarButton({
    super.key,
    required this.onPressed,
    required this.assetPath,
    this.color,
    required this.isExpanded,
    this.size = 24,
  });

  final VoidCallback onPressed;
  final String assetPath;
  final Color? color;
  final bool isExpanded;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isExpanded ? Alignment.centerRight : Alignment.center,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: SizedBox(
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
      ),
    );
  }
}
