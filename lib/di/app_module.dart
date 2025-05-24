import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/core_module.dart';
import 'package:listy_chef/feature/auth/child/sign_in/di/sign_in_module.dart';
import 'package:listy_chef/feature/auth/di/auth_module.dart';
import 'package:listy_chef/feature/root/di/root_module.dart';
import 'package:listy_chef/navigation/di/navigation_module.dart';

extension AppModule on GetIt {
  List<Type> registerAppModule() => [
    ...registerRootModule(),
    ...registerAuthModule(),
    ...registerNavigationModule(),
    ...registerCoreModule(),
    ...registerSignInModule(),
  ];
}
