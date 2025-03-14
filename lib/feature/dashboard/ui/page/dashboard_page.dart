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
    return Scaffold(
      backgroundColor: Colors.white,
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
                      ),

                      SizedBox(height: AppSize.p22),

                      Container(
                        width: 32,
                        height: 1,
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),

                      SizedBox(height: AppSize.p22),

                      IconButtonWidget(
                        assetPath: AppAssets.columns,
                        onPressed: () => navigationShell.goBranch(1),
                      ),

                      SizedBox(height: AppSize.p44),

                      IconButtonWidget(
                        assetPath: AppAssets.checkSquare,
                        onPressed: () => navigationShell.goBranch(1),
                      ),

                      SizedBox(height: AppSize.p44),

                      IconButtonWidget(
                        assetPath: AppAssets.briefcase,
                        onPressed: () => navigationShell.goBranch(1),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset(AppAssets.avatarAccount),
                        onPressed: () => navigationShell.goBranch(1),
                      ),

                      SizedBox(height: AppSize.p16),

                      Container(
                        width: 32,
                        height: 1,
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),

                      SizedBox(height: AppSize.p16),

                      IconButtonWidget(
                        assetPath: AppAssets.settings,
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
