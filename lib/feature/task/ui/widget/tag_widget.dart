import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.iconPath,
    required this.text,
    required this.backgroundColor,
  });

  final String iconPath;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.r8),
        border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.p8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconPath),
            SizedBox(width: AppSize.p4),
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF444444),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
