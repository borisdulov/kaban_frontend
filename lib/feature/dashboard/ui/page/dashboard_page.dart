import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/feature/dashboard/ui/widget/icon_button_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Row(
        children: [
          SizedBox(
            width: AppSize.p64,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 21),
              child: Column(
                children: [
                  Column(
                    children: [
                      IconButtonWidget(
                        assetPath: AppAssets.sideBar,
                        onPressed: () => navigationShell.goBranch(0),
                        color: colorScheme.onSurface,
                      ),

                      SizedBox(height: AppSize.p22),

                      Container(
                        width: 32,
                        height: 1,
                        color: colorScheme.onSurface.withOpacity(0.2),
                      ),

                      SizedBox(height: AppSize.p22),

                      IconButtonWidget(
                        assetPath: AppAssets.columns,
                        onPressed: () => navigationShell.goBranch(1),
                        color: colorScheme.onSurface,
                      ),

                      SizedBox(height: AppSize.p44),

                      IconButtonWidget(
                        assetPath: AppAssets.checkSquare,
                        onPressed: () => navigationShell.goBranch(1),
                        color: colorScheme.onSurface,
                      ),

                      SizedBox(height: AppSize.p44),

                      IconButtonWidget(
                        assetPath: AppAssets.briefcase,
                        onPressed: () => navigationShell.goBranch(1),
                        color: colorScheme.onSurface,
                      ),
                    ],
                  ),

                  const Spacer(),

                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset(AppAssets.avatarAccount),
                        onPressed: () => navigationShell.goBranch(1),
                        color: colorScheme.onSurface,
                      ),

                      SizedBox(height: AppSize.p16),

                      Container(
                        width: 32,
                        height: 1,
                        color: colorScheme.onSurface.withOpacity(0.4),
                      ),

                      SizedBox(height: AppSize.p16),

                      IconButtonWidget(
                        assetPath: AppAssets.settings,
                        onPressed: () => navigationShell.goBranch(1),
                        color: colorScheme.onSurface,
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
                  color: colorScheme.onSurface.withOpacity(0.2),
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
