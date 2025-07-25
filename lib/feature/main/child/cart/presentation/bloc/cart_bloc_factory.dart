import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/add_product_event_bus.dart';
import 'package:listy_chef/feature/main/child/cart/domain/check_product_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_bloc.dart';

final class CartBlocFactory {
  final TextChangeUseCase _textChangeUseCase;
  final LoadCartListsUseCase _loadCartListsUseCase;
  final CheckProductUseCase _checkProductUseCase;
  final ListDifferenceUseCase _listDifferenceUseCase;
  final AddProductEventBus _addProductEventBus;

  CartBlocFactory({
    required TextChangeUseCase textChangeUseCase,
    required LoadCartListsUseCase loadCartListsUseCase,
    required CheckProductUseCase checkProductUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required AddProductEventBus addProductEventBus,
  }) : _textChangeUseCase = textChangeUseCase,
    _loadCartListsUseCase = loadCartListsUseCase,
    _checkProductUseCase = checkProductUseCase,
    _listDifferenceUseCase = listDifferenceUseCase,
    _addProductEventBus = addProductEventBus;

  CartBloc call() => CartBloc(
    textChangeUseCase: _textChangeUseCase,
    loadCartListsUseCase: _loadCartListsUseCase,
    checkProductUseCase: _checkProductUseCase,
    listDifferenceUseCase: _listDifferenceUseCase,
    addProductEventBus: _addProductEventBus,
  );
}
