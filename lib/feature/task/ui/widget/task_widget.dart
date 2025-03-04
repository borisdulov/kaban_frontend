import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_radius.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_size.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: AppThemeSize.p16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeRadius.r8),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppThemeSize.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppThemeSize.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: AppThemeSize.p16),
              child: Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppThemeRadius.r8),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(AppThemeSize.p8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(width: AppThemeSize.p4),
                          Text('33 feb'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppThemeRadius.r8,
                      ),
                    ),
                    color: Color.fromRGBO(0, 255, 178, 0.2),
                    child: Padding(
                      padding: EdgeInsets.all(AppThemeSize.p8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bar_chart),
                          SizedBox(width: AppThemeSize.p4),
                          Text(task.priority.toString().split('.').last),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: AppThemeSize.p16,
                top: AppThemeSize.p8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.account_circle),
                  Icon(Icons.account_circle),
                  Icon(Icons.account_circle),
                  SizedBox(width: AppThemeSize.p8),
                  Text('+1'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
