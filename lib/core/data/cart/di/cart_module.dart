import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/data/cart/repository/cart_repository_impl.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';

extension CartModule on GetIt {
  List<Type> registerCartModule() => [
    provideSingleton<CartRepository>(() => CartRepositoryImpl()),
  ];
}