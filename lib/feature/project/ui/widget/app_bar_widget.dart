import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/theme/domain/cubit/theme_bloc.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_radius.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Project project;

  const AppBarWidget({super.key, required this.project});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: context.colorScheme.error, width: 1),
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
                            borderRadius: BorderRadius.circular(
                              AppThemeRadius.r8,
                            ),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppThemeRadius.r8,
                            ),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppThemeRadius.r8,
                            ),
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
                //TODO вынести
                Image.asset('assets/png/avatar_group.png'),

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
