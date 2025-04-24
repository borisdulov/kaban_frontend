import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/board/ui/page/board_page.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({super.key, required this.board});

  final Board board;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 192,
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
        child: InkWell(
          onTap: () {
            context.go('${BoardPage.path}${board.id}');
          },
          borderRadius: BorderRadius.circular(AppRadius.r8),
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppSize.p12,
              left: AppSize.p12,
              bottom: AppSize.p8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(board.title),
                SizedBox(height: AppSize.p24),
                Image.asset(AppAssets.avatarAccount, width: AppSize.p24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
