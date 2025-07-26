import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/data/auth/di/auth_module.dart';
import 'package:listy_chef/core/data/cart/di/cart_module.dart';
import 'package:listy_chef/core/di/provide.dart';

extension DataModule on GetIt {
  List<DiEntity> registerDataModule() => [
    ...registerAuthModule(),
    ...registerCartModule(),
  ];
}
