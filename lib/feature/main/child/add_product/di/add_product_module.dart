import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_bloc_factory.dart';

extension AddProductModule on GetIt {
  List<Type> registerAddProductModule() => [
    provideSingleton(() => AddProductBlocFactory(textChangeUseCase: this())),
  ];
}
