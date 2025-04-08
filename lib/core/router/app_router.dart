import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/router/app_router_guards.dart';
import 'package:kaban_frontend/core/router/navigation_key.dart';
import 'package:kaban_frontend/feature/dashboard/ui/page/dashboard_page.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_bloc.dart';
import 'package:kaban_frontend/feature/board/ui/page/project_page.dart';

abstract final class AppRouter {
  static final config = GoRouter(
    navigatorKey: NavigationKey.root,
    initialLocation: "/placeholder",
    routes: [
      ShellRoute(
        navigatorKey: NavigationKey.dashboardKey,
        redirect: AppRouterGuards.authorized,
        builder: (context, state, child) => child,
        routes: [
          StatefulShellRoute.indexedStack(
            builder:
                (context, state, navigationShell) =>
                    DashboardPage(navigationShell: navigationShell),
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: ProjectPage.path,
                    name: ProjectPage.name,
                    builder:
                        (context, state) => MultiBlocProvider(
                          providers: [BoardCubit.provider(projectId: '1')],
                          child: ProjectPage(),
                        ),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/placeholder',
                    builder: (context, state) => Placeholder(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      ShellRoute(
        navigatorKey: NavigationKey.signKey,
        redirect: AppRouterGuards.unauthorized,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: '/auth/login',
            builder: (context, state) => Placeholder(),
          ),
          GoRoute(
            path: '/auth/register',
            builder: (context, state) => Placeholder(),
          ),
        ],
      ),

      ShellRoute(
        navigatorKey: NavigationKey.publicKey,
        redirect: AppRouterGuards.public,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: '/auth/loading',
            builder: (context, state) => Placeholder(),
          ),
        ],
      ),
    ],
  );
}
