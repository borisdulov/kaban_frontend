import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';

class ColumnBoardHeader extends StatelessWidget {
  const ColumnBoardHeader({
    super.key,
    required this.onTaskCreate,
    required this.onMenuPressed,
    required this.title,
  });

  final VoidCallback onTaskCreate;
  final VoidCallback onMenuPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppFlowyGroupHeader(
      title: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: AppThemeSize.p8,
              children: [
                const Icon(Icons.circle, color: Colors.green, size: 16),
                Text(title, overflow: TextOverflow.ellipsis),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onTaskCreate,
                  icon: Icon(
                    Icons.add,
                    size: 20,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
                IconButton(
                  onPressed: onMenuPressed,
                  icon: Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Color.fromRGBO(68, 68, 68, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.only(left: AppThemeSize.p16),
    );
  }
}
