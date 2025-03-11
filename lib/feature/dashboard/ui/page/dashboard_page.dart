import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_size.dart';
import 'package:kaban_frontend/feature/dashboard/ui/widget/icon_button_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          SizedBox(
            width: AppThemeSize.p64,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 21),
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
