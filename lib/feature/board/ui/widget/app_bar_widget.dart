import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/core/theme/data/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/theme/ui/widget/theme_change_button.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';

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
            color: context.colorScheme.onSurface.withOpacity(0.4),
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
              child: Text(board.title),
            ),

            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppThemeSize.p8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: context.colorScheme.surface,
                          hintText: 'Search...',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: context.colorScheme.onSurface.withOpacity(
                              0.4,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: context.colorScheme.onSurface.withOpacity(
                              0.4,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 11,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                            borderSide: BorderSide(
                              color: context.colorScheme.outline.withOpacity(
                                0.4,
                              ),
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                            borderSide: BorderSide(
                              color: context.colorScheme.outline.withOpacity(
                                0.4,
                              ),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                            borderSide: BorderSide(
                              color: context.colorScheme.outline.withOpacity(
                                0.4,
                              ),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThemeChangeButton(),
                Image.asset(AppAssets.avatarGroup),
                SizedBox(width: AppThemeSize.p8),
                Text(
                  '+1',
                  style: GoogleFonts.roboto(
                    color: context.colorScheme.onSurface.withOpacity(0.4),
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
