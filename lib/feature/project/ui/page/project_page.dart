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
      appBar: AppBar(
        leadingWidth: 150,
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppThemeSize.p24,
            vertical: AppThemeSize.p12,
          ),
          child: Text('Project Name', style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w400
          )),
        ),
        title: SmoothCard(
          borderRadius: BorderRadius.circular(AppThemeRadius.r8),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(children: [Icon(Icons.search), Text('Search...')]),
          ),
        ),
        actions: [Image.asset('assets/png/avatar_group.png')],
      ),
      body: MultiBoardListExample(),
    );
  }
}
