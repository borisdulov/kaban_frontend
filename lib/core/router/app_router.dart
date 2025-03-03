import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/router/navigation_key.dart';
import 'package:kaban_frontend/feature/navigation/presentation/page/navigation_page.dart';
import 'package:kaban_frontend/feature/project/presentation/page/project_page.dart';

abstract final class AppRouter {
  static final config = GoRouter(
    navigatorKey: NavigationKey.root,
    initialLocation: ProjectPage.path,
    routes: [
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              NavigationPage(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                path: ProjectPage.path,
                name: ProjectPage.name,
                builder: (context, state) => ProjectPage(),
              )
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/placeholder',
                name: 'Placeholder',
                builder: (context, state) => Placeholder(),
              )
            ])
          ])
    ],
  );
}
