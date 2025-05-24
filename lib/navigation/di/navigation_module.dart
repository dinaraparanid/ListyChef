import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/navigation/app_router.dart';

extension NavigationModule on GetIt {
  List<Type> registerNavigationModule() => [
    provideSingleton(() => AppRouter()),
  ];
}
