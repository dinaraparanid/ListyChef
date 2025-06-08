import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/navigation/app_router.dart';
import 'package:listy_chef/navigation/observer/auth_navigator_observer.dart';
import 'package:listy_chef/navigation/observer/main_navigator_observer.dart';

extension NavigationModule on GetIt {
  List<Type> registerNavigationModule() => [
    provideSingleton(() => AuthNavigatorObserver()),
    provideSingleton(() => MainNavigatorObserver()),

    provideSingleton(() => AppRouter(
      authObserver: this(),
      mainObserver: this(),
    )),
  ];
}
