import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/theme/domain/cubit/theme_bloc.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.project});

  final Project project;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: context.colorScheme.onSurface, width: 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppThemeSize.p24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppThemeSize.p12),
              child: Text(
                project.name,
                style: context.themeData.textTheme.titleLarge,
              ),
            ),

            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppThemeSize.p8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search...',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 11,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.avatarGroup),
                SizedBox(width: AppThemeSize.p8),
                Text(
                  '+1',
                  style: GoogleFonts.roboto(
                    color: Color.fromRGBO(117, 117, 117, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
