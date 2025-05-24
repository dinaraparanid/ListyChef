import 'dart:async';
import 'package:dartx/dartx.dart';
import 'package:flutter/widgets.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/app_route_data.dart';
import 'package:listy_chef/navigation/app_router.dart';

abstract class AppNavigatorObserver extends NavigatorObserver {

  @protected
  final List<AppRouteData> backStack = [];

  Object? _tmpExtra;

  abstract final FutureOr<AppRouteData> redirectRoute;

  FutureOr<AppRoute> get redirectPath async {
    final redirect = await redirectRoute;
    return AppRoute.values.firstWhere((route) => route.name == redirect.name);
  }

  FutureOr<Object?> get extra async => (await redirectRoute).extra;

  AppRouteData? findPreviousRoute(bool Function(AppRouteData) predicate) =>
      backStack.reversed.firstOrNullWhere(predicate);

  void storeExtra(Object? extra) {
    if (extra != null) _tmpExtra = extra;
  }

  void clear() => backStack.clear();

  @override
  void didPush(Route route, Route? previousRoute) {
    final config = di<AppRouter>().value.routerDelegate.currentConfiguration;
    final name = config.last.route.name;

    if (name != null) {
      backStack.add(AppRouteData(name: name, extra: _tmpExtra));
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    backStack.removeLast();
  }
}
