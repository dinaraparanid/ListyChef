import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_bloc.dart';

final class CartBlocFactory {
  final TextChangeUseCase _textChangeUseCase;
  final LoadCartListsUseCase _loadCartListsUseCase;

  CartBlocFactory({
    required TextChangeUseCase textChangeUseCase,
    required LoadCartListsUseCase loadCartListsUseCase,
  }) : _textChangeUseCase = textChangeUseCase,
    _loadCartListsUseCase = loadCartListsUseCase;

  CartBloc call() => CartBloc(
    textChangeUseCase: _textChangeUseCase,
    loadCartListsUseCase: _loadCartListsUseCase,
  );
}
