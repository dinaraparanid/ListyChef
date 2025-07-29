import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/product_input/domain/add_product_use_case.dart';
import 'package:listy_chef/feature/main/child/product_input/domain/update_product_use_case.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/mod.dart';

extension AddProductModule on GetIt {
  List<DiEntity> registerAddProductModule() => [
    provideSingleton(() => AddProductUseCase(
      cartRepository: this(),
      authRepository: this(),
    )),

    provideSingleton(() => UpdateProductUseCase(cartRepository: this())),

    provideSingleton(() => ProductInputBlocFactory(
      textChangeUseCase: this(),
      addProductUseCase: this(),
      updateProductUseCase: this(),
      loadCartListsEventBus: this(),
    )),
  ];
}
