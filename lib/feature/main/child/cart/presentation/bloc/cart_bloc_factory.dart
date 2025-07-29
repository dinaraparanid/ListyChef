import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/delete_product_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_event_bus.dart';
import 'package:listy_chef/feature/main/child/cart/domain/check_product_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_bloc.dart';

final class CartBlocFactory {
  final TextChangeUseCase _textChangeUseCase;
  final LoadCartListsUseCase _loadCartListsUseCase;
  final CheckProductUseCase _checkProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final ListDifferenceUseCase _listDifferenceUseCase;
  final LoadCartListsEventBus _addProductEventBus;

  CartBlocFactory({
    required TextChangeUseCase textChangeUseCase,
    required LoadCartListsUseCase loadCartListsUseCase,
    required CheckProductUseCase checkProductUseCase,
    required DeleteProductUseCase deleteProductUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required LoadCartListsEventBus addProductEventBus,
  }) : _textChangeUseCase = textChangeUseCase,
    _loadCartListsUseCase = loadCartListsUseCase,
    _checkProductUseCase = checkProductUseCase,
    _deleteProductUseCase = deleteProductUseCase,
    _listDifferenceUseCase = listDifferenceUseCase,
    _addProductEventBus = addProductEventBus;

  CartBloc call() => CartBloc(
    textChangeUseCase: _textChangeUseCase,
    loadCartListsUseCase: _loadCartListsUseCase,
    checkProductUseCase: _checkProductUseCase,
    deleteProductUseCase: _deleteProductUseCase,
    listDifferenceUseCase: _listDifferenceUseCase,
    addProductEventBus: _addProductEventBus,
  );
}
