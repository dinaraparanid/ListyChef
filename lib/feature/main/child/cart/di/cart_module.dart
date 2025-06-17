import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_bloc_factory.dart';

extension CartModule on GetIt {
  List<Type> registerCartModule() => [
    provideSingleton(() => CartBlocFactory()),
  ];
}
