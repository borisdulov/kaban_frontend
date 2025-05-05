import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/board/ui/widget/board_menu.dart';
import 'package:kaban_frontend/feature/board/ui/widget/title_edit_widget.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({super.key, required this.board});

  final Board board;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 96,
      child: Card(
        color: context.colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.colorScheme.onSurface.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.r8),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSize.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 170, child: TitleEditWidget(board: board)),
                ],
              ),
            ),
            Positioned(top: 4, right: 4, child: BoardMenu(board: board)),
          ],
        ),
      ),
    );
  }
}
