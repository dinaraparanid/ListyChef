import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/sign_in_screen.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/sign_up_screen.dart';
import 'package:listy_chef/feature/auth/presentation/auth_screen.dart';
import 'package:listy_chef/feature/root/presentation/root_screen.dart';
import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/observer/auth_navigator_observer.dart';

final class AppRouter {
  final AuthNavigatorObserver _authObserver;

  AppRouter({
    required AuthNavigatorObserver authObserver,
  }) : _authObserver = authObserver;

  void clearBackStackHistory() {
    _authObserver.clear();

    while (value.canPop()) {
      value.pop();
    }
  }

  late final value = GoRouter(
    initialLocation: AppRoute.root.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) => RootScreen(
          blocFactory: di(),
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppRoute.root.path,
            name: AppRoute.root.name,
            builder: (context, state) => SizedBox(),
          ),
          ShellRoute(
            observers: [_authObserver],
            builder: (context, state, child) => AuthScreen(
              blocFactory: di(),
              child: child,
            ),
            routes: [
              GoRoute(
                path: AppRoute.auth.path,
                name: AppRoute.auth.name,
                redirect: (context, state) async {
                  final route = await _authObserver.redirectPath;
                  return route.path;
                },
              ),
              GoRoute(
                path: AppRoute.signIn.path,
                name: AppRoute.signIn.name,
                builder: (context, state) => SignInScreen(blocFactory: di()),
              ),
              GoRoute(
                path: AppRoute.signUp.path,
                name: AppRoute.signUp.name,
                builder: (context, state) => SignUpScreen(blocFactory: di()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
