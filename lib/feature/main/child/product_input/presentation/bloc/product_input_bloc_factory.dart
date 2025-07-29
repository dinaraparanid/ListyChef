import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/product_input/domain/add_product_use_case.dart';
import 'package:listy_chef/feature/main/child/product_input/domain/update_product_use_case.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/product_input_bloc.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_event_bus.dart';
import 'package:listy_chef/feature/main/child/product_input/presentation/bloc/product_input_state.dart';

final class ProductInputBlocFactory {
  final TextChangeUseCase _textChangeUseCase;
  final AddProductUseCase _addProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  final LoadCartListsEventBus _loadCartListsEventBus;

  ProductInputBlocFactory({
    required TextChangeUseCase textChangeUseCase,
    required AddProductUseCase addProductUseCase,
    required UpdateProductUseCase updateProductUseCase,
    required LoadCartListsEventBus loadCartListsEventBus,
  }) : _textChangeUseCase = textChangeUseCase,
    _addProductUseCase = addProductUseCase,
    _updateProductUseCase = updateProductUseCase,
    _loadCartListsEventBus = loadCartListsEventBus;

  ProductInputBloc call({
    required ProductInputMode mode,
    Product? initialProduct,
  }) => ProductInputBloc(
    mode: mode,
    initialProduct: initialProduct,
    textChangeUseCase: _textChangeUseCase,
    addProductUseCase: _addProductUseCase,
    updateProductUseCase: _updateProductUseCase,
    loadCartListsEventBus: _loadCartListsEventBus,
  );
}
