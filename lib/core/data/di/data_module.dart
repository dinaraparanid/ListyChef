import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/data/auth/di/auth_module.dart';

extension DataModule on GetIt {
  List<Type> registerDataModule() => [
    ...registerAuthModule(),
  ];
}
