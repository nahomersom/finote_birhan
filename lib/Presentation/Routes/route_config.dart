import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hisnate_kifele/Presentation/Screens/Home/UI/Dashboard.dart';
import 'package:hisnate_kifele/Presentation/Screens/Login/UI/login.dart';
import 'package:hisnate_kifele/Presentation/Screens/Registration/UI/kifile_selector.dart';
import 'package:hisnate_kifele/Presentation/Screens/Registration/UI/registeration.dart';
import 'package:hisnate_kifele/Presentation/Screens/Workspace/UI/workspace.dart';
import 'package:hisnate_kifele/global.dart';

class RouteConfig {
  // static UserAccount? currentUser = CurrentUser().userAccount;

  // static String initialLocation = '/admin-care-list';
  static String initialLocation = '/dashboard/kifile';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _exploreNavigatorAKey =
      GlobalKey<NavigatorState>(debugLabel: 'Explore');

  static final _dontateNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'donate');

  static final _accountNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'account');

  static final _resourcesNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'resources');

  static GoRouter returnRouter({required bool isAuth}) {
    GoRouter router = GoRouter(
      // initialLocation:
      //     (isAuth && currentUserId != null) ? initialLocation : '/start',
      initialLocation: initialLocation,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNestedNavigation(
                navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _exploreNavigatorAKey,
              routes: [
                GoRoute(
                    path: '/dashboard',
                    pageBuilder: (context, state) => NoTransitionPage(
                          child: DashboardScreen(),
                        ),
                    routes: [
                      GoRoute(
                          path: 'kifile',
                          builder: (context, state) {
                            return KifileSelector();
                          },
                          routes: [
                            GoRoute(
                              path: 'registration',
                              builder: (context, state) {
                                return RegistrationScreen();
                              },
                            )
                          ])
                    ]),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _dontateNavigatorKey,
              routes: [
                GoRoute(
                  path: "/donate",
                  name: "donate",
                  builder: (context, state) {
                    return DashboardScreen();
                  },
                )
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _accountNavigatorKey,
              routes: [
                GoRoute(
                  path: '/account',
                  builder: (context, state) {
                    return const DashboardScreen();
                  },
                )
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _resourcesNavigatorKey,
              routes: [
                // Shopping Cart
                GoRoute(
                  path: '/resources',
                  builder: (context, state) {
                    return const DashboardScreen();
                  },
                )
              ],
            ),
          ],
        ),
      ],
    );

    return router;
  }
}
