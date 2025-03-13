import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_radius.dart';
import 'package:smooth_corner/smooth_corner.dart';

class AddColumnButton extends StatelessWidget {
  const AddColumnButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SmoothCard(
      elevation: 0,
      borderRadius: BorderRadius.circular(AppThemeRadius.r16),
      color: const Color.fromRGBO(248, 246, 245, 1),
      child: SizedBox(
        height: AppThemeSize.p40,
        child: IconButton(
          onPressed: onPressed,
          icon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppThemeSize.p8),
            child: Row(
              children: [
                Icon(Icons.add, size: 20),
                SizedBox(width: AppThemeSize.p4),
                Text(
                  'Add Column',
                  style: GoogleFonts.inter(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
