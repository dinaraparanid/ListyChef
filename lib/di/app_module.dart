import 'package:get_it/get_it.dart';
import 'package:listy_chef/feature/root/di/root_module.dart';
import 'package:listy_chef/navigation/di/navigation_module.dart';

extension AppModule on GetIt {
  List<Type> registerAppModule() => [
    ...registerRootModule(),
    ...registerNavigationModule(),
  ];
}
