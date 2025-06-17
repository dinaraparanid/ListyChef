import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/cart/di/cart_module.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_bloc_factory.dart';

extension MainModule on GetIt {
  List<Type> registerMainModule() => [
    ...registerCartModule(),
    provideSingleton(() => MainBlocFactory(router: this())),
  ];
}
