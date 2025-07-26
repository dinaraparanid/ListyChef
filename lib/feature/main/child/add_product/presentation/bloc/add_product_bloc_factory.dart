import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/add_product/domain/add_product_use_case.dart';
import 'package:listy_chef/feature/main/child/add_product/presentation/bloc/add_product_bloc.dart';
import 'package:listy_chef/feature/main/child/cart/domain/add_product_event_bus.dart';

final class AddProductBlocFactory {
  final TextChangeUseCase _textChangeUseCase;
  final AddProductUseCase _addProductUseCase;
  final AddProductEventBus _addProductEventBus;

  AddProductBlocFactory({
    required TextChangeUseCase textChangeUseCase,
    required AddProductUseCase addProductUseCase,
    required AddProductEventBus addProductEventBus,
  }) : _textChangeUseCase = textChangeUseCase,
    _addProductUseCase = addProductUseCase,
    _addProductEventBus = addProductEventBus;

  AddProductBloc call() => AddProductBloc(
    textChangeUseCase: _textChangeUseCase,
    addProductUseCase: _addProductUseCase,
    addProductEventBus: _addProductEventBus,
  );
}
