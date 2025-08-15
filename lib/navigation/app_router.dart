import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/sign_in_screen.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/sign_up_screen.dart';
import 'package:listy_chef/feature/auth/presentation/auth_screen.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/folder_screen.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/folders_screen.dart';
import 'package:listy_chef/feature/main/presentation/main_screen.dart';
import 'package:listy_chef/feature/root/presentation/root_screen.dart';
import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/observer/auth_navigator_observer.dart';
import 'package:listy_chef/navigation/observer/main_navigator_observer.dart';

final class AppRouter {
  final AuthNavigatorObserver _authObserver;
  final MainNavigatorObserver _mainObserver;

  AppRouter({
    required AuthNavigatorObserver authObserver,
    required MainNavigatorObserver mainObserver,
  }) : _authObserver = authObserver, _mainObserver = mainObserver;

  void clearBackStackHistory() {
    _authObserver.clear();
    _mainObserver.clear();

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
                builder: (context, state) => SignInScreen(
                  email: state.uri.queryParameters[AppRoute.queryEmail],
                  blocFactory: di(),
                ),
              ),
              GoRoute(
                path: AppRoute.signUp.path,
                name: AppRoute.signUp.name,
                builder: (context, state) => SignUpScreen(
                  email: state.uri.queryParameters[AppRoute.queryEmail],
                  blocFactory: di(),
                ),
              ),
            ],
          ),
          ShellRoute(
            observers: [_mainObserver],
            builder: (context, state, child) => MainScreen(
              blocFactory: di(),
              child: child,
            ),
            routes: [
              GoRoute(
                path: AppRoute.main.path,
                name: AppRoute.main.name,
                redirect: (context, state) async {
                  final route = await _mainObserver.redirectPath;
                  return route.path;
                },
              ),
              GoRoute(
                path: AppRoute.folders.path,
                name: AppRoute.folders.name,
                builder: (context, state) => FoldersScreen(blocFactory: di()),
              ),
              GoRoute(
                path: AppRoute.folder.path,
                name: AppRoute.folder.name,
                builder: (context, state) {
                  final folderId = state.pathParameters[AppRoute.pathFolderId];

                  if (folderId == null) {
                    // TODO: redirect to unknown page 404
                    return SizedBox();
                  }

                  return FolderScreen(
                    folderId: FolderId(folderId),
                    blocFactory: di(),
                  );
                },
              ),
              GoRoute(
                path: AppRoute.transfer.path,
                name: AppRoute.transfer.name,
                builder: (context, state) => Text('TODO: TransferScreen()'),
              ),
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                builder: (context, state) => Text('TODO: ProfileScreen()'),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
