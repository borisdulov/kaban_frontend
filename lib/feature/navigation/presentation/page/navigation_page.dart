import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () => navigationShell.goBranch(0),
                      icon: Image.asset(
                        'assets/png/sidebar.png',
                        width: 20,
                        height: 20,
                      ),
                    ),

                    SizedBox(height: 22),

                    Container(
                      width: 32,
                      height: 1,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),

                    SizedBox(height: 22),

                    IconButton(
                      onPressed: () => navigationShell.goBranch(1),
                      icon: Image.asset('assets/png/columns.png'),
                    ),

                    SizedBox(height: 22),

                    IconButton(
                      onPressed: () => navigationShell.goBranch(1),
                      icon: Image.asset('assets/png/check_square.png'),
                    ),

                    SizedBox(height: 22),

                    IconButton(
                      onPressed: () => navigationShell.goBranch(1),
                      icon: Image.asset('assets/png/briefcase.png'),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppThemeSize.p16,
                  vertical: AppThemeSize.p16,
                ),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () => navigationShell.goBranch(1),
                      icon: Image.asset(
                        'assets/png/avatar_account.png',
                        width: 32,
                        height: 32,
                      ),
                    ),

                    SizedBox(height: 16),

                    Container(
                      width: 32,
                      height: 1,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),

                    // SizedBox(height: 16),
                    
                    IconButton(
                      onPressed: () => navigationShell.goBranch(1),
                      icon: Image.asset(
                        'assets/png/settings.png',
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.all(1),
            width: 1,
            height: double.infinity,
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),

          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}
