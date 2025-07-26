import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/cart/domain/add_product_event_bus.dart';
import 'package:listy_chef/feature/main/child/cart/domain/check_product_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_bloc_factory.dart';

extension CartModule on GetIt {
  List<DiEntity> registerCartModule() => [
    provideSingleton(() => LoadCartListsUseCase(
      cartRepository: this(),
      authRepository: this(),
    )),
    provideSingleton(() => CheckProductUseCase(cartRepository: this())),
    provideSingleton(() => AddProductEventBus()),
    provideSingleton(() => CartBlocFactory(
      textChangeUseCase: this(),
      loadCartListsUseCase: this(),
      checkProductUseCase: this(),
      listDifferenceUseCase: this(),
      addProductEventBus: this(),
    )),
  ];
}
