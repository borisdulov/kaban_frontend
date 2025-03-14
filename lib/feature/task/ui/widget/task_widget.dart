import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return AppFlowyGroupCard(
      key: ValueKey('${task.taskId}52'),
      margin: EdgeInsets.symmetric(vertical: AppSize.p8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.r16),
        border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: AppSize.p4),
                  child: Text(
                    task.title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(68, 68, 68, 1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                  height: 32,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      size: 16,
                      color: Color.fromRGBO(30, 30, 30, 1),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.p8),
            Row(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.p8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppAssets.clock),
                        SizedBox(width: AppSize.p4),
                        Text(
                          task.dueDate != null
                              ? DateFormat('dd.MM').format(task.dueDate!)
                              : '--.--',
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
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                  ),
                  elevation: 0,
                  color: Color.fromRGBO(0, 255, 178, 0.2),
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.p8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppAssets.barChart),
                        SizedBox(width: AppSize.p4),
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
            SizedBox(height: AppSize.p8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.avatarGroup),
                SizedBox(width: AppSize.p8),
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
