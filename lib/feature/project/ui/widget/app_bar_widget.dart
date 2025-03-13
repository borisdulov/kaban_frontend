import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/theme/domain/cubit/theme_bloc.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_radius.dart';
import 'package:smooth_corner/smooth_corner.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

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
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppThemeSize.p12),
                  child: Text(
                    'Project Name', //TODO выносить как переменную
                    style: context.themeData.textTheme.titleSmall,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppThemeSize.p8),
                //TODO вместо smoothcard сделать textfield
                child: SmoothCard(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(AppThemeRadius.r8),
                  side: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
                  color: Colors.white,
                  smoothness: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 11),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 0.4)),

                        SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            'Search...',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
