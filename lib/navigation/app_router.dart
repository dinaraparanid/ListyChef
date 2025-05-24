import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/feature/root/presentation/root_screen.dart';
import 'package:listy_chef/navigation/app_route.dart';

final class AppRouter {
  AppRouter();

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
        ]
      ),
    ],
  );
}
