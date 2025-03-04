import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kaban_frontend/core/theme/entity/app_theme_radius.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_size.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:smooth_corner/smooth_corner.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({super.key, required this.task});

  static const String name = 'task';
  static const String path = '/task';

  @override
  Widget build(BuildContext context) {
    return SmoothCard(
      margin: EdgeInsets.symmetric(horizontal: AppThemeSize.p16, vertical: 10),
      borderRadius: BorderRadius.circular(AppThemeRadius.r8),
      side: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2), width: 1),
      smoothness: 2,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(AppThemeSize.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: AppThemeSize.p4),
                  child: Text(
                    task.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(68, 68, 68, 1),
                    ),
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  size: 24,
                  color: Color.fromRGBO(30, 30, 30, 1),
                ),
              ],
            ),
            SizedBox(height: AppThemeSize.p16),
            Row(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
                    borderRadius: BorderRadius.circular(AppThemeRadius.r8),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(AppThemeSize.p8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/png/clock.png',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: AppThemeSize.p4),
                        Text(
                          '33 feb',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(68, 68, 68, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
                    borderRadius: BorderRadius.circular(AppThemeRadius.r8),
                  ),
                  color: Color.fromRGBO(0, 255, 178, 0.2),
                  child: Padding(
                    padding: EdgeInsets.all(AppThemeSize.p8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/png/bar_chart.png',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: AppThemeSize.p4),
                        Text(
                          task.priority.toString().split('.').last,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(68, 68, 68, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppThemeSize.p8),
            Row(
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
          ],
        ),
      ),
    );
  }
}
