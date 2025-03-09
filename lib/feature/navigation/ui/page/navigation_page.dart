import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_size.dart';
import 'package:kaban_frontend/feature/navigation/ui/widget/icon_button_widget.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppThemeSize.p22),
            child: Column(
              children: [
                Column(
                  children: [
                    IconButtonWidget(
                      assetPath: 'assets/png/sidebar.png',
                      onPressed: () => navigationShell.goBranch(0),
                    ),

                    SizedBox(height: AppThemeSize.p22),

                    Container(
                      width: 32,
                      height: 1,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),

                    SizedBox(height: AppThemeSize.p22),

                    IconButtonWidget(
                      onPressed: () => navigationShell.goBranch(1),
                      assetPath: 'assets/png/columns.png',
                    ),

                    SizedBox(height: AppThemeSize.p44),

                    IconButtonWidget(
                      assetPath: 'assets/png/check_square.png',
                      onPressed: () => navigationShell.goBranch(1),
                    ),

                    SizedBox(height: AppThemeSize.p44),

                    IconButtonWidget(
                      assetPath: 'assets/png/briefcase.png',
                      onPressed: () => navigationShell.goBranch(1),
                    ),
                  ],
                ),

                const Spacer(),

                Column(
                  children: [
                    IconButtonWidget(
                      assetPath: 'assets/png/avatar_account.png',
                      onPressed: () => navigationShell.goBranch(1),
                      size: 32,
                    ),

                    SizedBox(height: AppThemeSize.p16),

                    Container(
                      width: 32,
                      height: 1,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),

                    SizedBox(height: AppThemeSize.p16),

                    IconButtonWidget(
                      assetPath: 'assets/png/settings.png',
                      onPressed: () => navigationShell.goBranch(1),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  width: 1,
                ),
              ),
            ),
          ),

          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}
