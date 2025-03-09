import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_radius.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_size.dart';
import 'package:kaban_frontend/multi_board_list_example.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  static const String name = 'Project';
  static const String path = '/project';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2), width: 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppThemeSize.p24),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppThemeSize.p12),
                      child: Text(
                        'Project Name',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(68, 68, 68, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppThemeSize.p8),
                    child: SmoothCard(
                      borderRadius: BorderRadius.circular(AppThemeRadius.r8),
                      side: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
                      color: Colors.white,
                      smoothness: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 11,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search,
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                            ),

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
        ),
      ),
      body: MultiBoardListExample(),
    );
  }
}
