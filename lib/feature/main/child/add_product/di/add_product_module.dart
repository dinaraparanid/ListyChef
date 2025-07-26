import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/add_product/domain/add_product_use_case.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_bloc_factory.dart';

extension AddProductModule on GetIt {
  List<DiEntity> registerAddProductModule() => [
    provideSingleton(() => AddProductUseCase(
      cartRepository: this(),
      authRepository: this(),
    )),

    provideSingleton(() => AddProductBlocFactory(
      textChangeUseCase: this(),
      addProductUseCase: this(),
      addProductEventBus: this(),
    )),
  ];
}
