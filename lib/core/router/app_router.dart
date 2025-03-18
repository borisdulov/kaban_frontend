import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/router/navigation_key.dart';
import 'package:kaban_frontend/feature/dashboard/ui/page/dashboard_page.dart';
import 'package:kaban_frontend/feature/project/bloc/board/board_bloc.dart';
import 'package:kaban_frontend/feature/project/data/repository/project_repository_mock_impl.dart';

import 'package:kaban_frontend/feature/project/ui/page/project_page.dart';

abstract final class AppRouter {
  static final config = GoRouter(
    navigatorKey: NavigationKey.root,
    initialLocation: "/placeholder",
    routes: [
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) =>
                DashboardPage(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/placeholder',
                name: 'Placeholder',
                builder: (context, state) => Placeholder(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ProjectPage.path,
                name: ProjectPage.name,
                builder:
                    (context, state) => BlocProvider(
                      create:
                          (BuildContext context) => BoardCubit(
                            projectRepository: ProjectRepositoryMockImpl(),
                            projectId: '1',
                          ),
                      child: ProjectPage(),
                    ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
