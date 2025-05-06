import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/router/app_router_guards.dart';
import 'package:kaban_frontend/core/router/navigation_key.dart';
import 'package:kaban_frontend/feature/auth/ui/page/log_in_page.dart';
import 'package:kaban_frontend/feature/auth/ui/page/sing_up_page.dart';
import 'package:kaban_frontend/feature/board/ui/page/board_list_page.dart';
import 'package:kaban_frontend/feature/board/ui/page/settings_page.dart';
import 'package:kaban_frontend/feature/dashboard/ui/page/dashboard_page.dart';
import 'package:kaban_frontend/feature/board/bloc/board/board_bloc.dart';
import 'package:kaban_frontend/feature/board/ui/page/board_page.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/ui/page/task_edit_page.dart';

abstract final class AppRouter {
  static final config = GoRouter(
    navigatorKey: NavigationKey.root,
    initialLocation: "/placeholder",
    routes: [
      ShellRoute(
        navigatorKey: NavigationKey.dashboardKey,
        redirect: AppRouterGuards.authorized,
        builder:
            (context, state, child) => MultiBlocProvider(
              providers: [BoardCubit.provider(boardId: '1')],
              child: child,
            ),
        routes: [
          StatefulShellRoute.indexedStack(
            builder:
                (context, state, navigationShell) =>
                    DashboardPage(navigationShell: navigationShell),
            branches: [
              StatefulShellBranch(
                initialLocation: '/board/1',
                routes: [
                  GoRoute(
                    path: '${BoardPage.path}:id',
                    name: BoardPage.name,
                    builder: (context, state) {
                      final id = state.pathParameters['id'] ?? '1';
                      return BlocProvider(
                        create:
                            (context) => BoardCubit.from(context, boardId: id),
                        child: BoardPage(boardId: id),
                      );
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                initialLocation: BoardListPage.path,
                routes: [
                  GoRoute(
                    path: BoardListPage.path,
                    name: BoardListPage.name,
                    builder: (context, state) => BoardListPage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: SettingsPage.path,
                    name: SettingsPage.name,
                    builder: (context, state) => SettingsPage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                initialLocation: '/placeholder',
                routes: [
                  GoRoute(
                    path: '/placeholder',
                    builder: (context, state) => Placeholder(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: TaskEditPage.path,
            name: TaskEditPage.name,
            builder:
                (context, state) => TaskEditPage(task: state.extra as Task),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: NavigationKey.signKey,
        //! redirect: AppRouterGuards.unauthorized,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: LogInPage.path,
            name: LogInPage.name,
            builder: (context, state) => LogInPage(),
          ),
          GoRoute(
            path: SignUpPage.path,
            name: SignUpPage.name,
            builder: (context, state) => SignUpPage(),
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
