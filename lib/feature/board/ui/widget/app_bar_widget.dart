import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/core/theme/data/entity/app_theme_size.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/board/ui/widget/search_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.board});

  final Board board;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.onSurface.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppThemeSize.p24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppThemeSize.p12),
              child: Text(board.title, style: context.textTheme.titleLarge),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppThemeSize.p8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SearchWidget();
                  },
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.users,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: AppThemeSize.p8),
                Text(
                  '4',
                  style: TextStyle(
                    color: context.colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
