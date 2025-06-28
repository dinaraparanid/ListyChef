import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_event.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_state.dart';

final class CartBloc extends Bloc<CartEvent, CartState> {

  late final StreamSubscription<(
    UiState<IList<Product>>,
    UiState<IList<Product>>,
  )>? _cartListsListener;

  CartBloc({
    required TextChangeUseCase textChangeUseCase,
    required LoadCartListsUseCase loadCartListsUseCase,
  }) : super(CartState()) {
    on<EventSearchQueryChange>((event, emit) {
      textChangeUseCase(
        next: event.query,
        errorPredicate: (_) => null,
        update: (textContainer) =>
          emit(state.copyWith(searchQuery: textContainer)),
      );
    });

    on<EventUpdateLists>((event, emit) => emit(state.copyWith(
      todoProductsState: event.todoProductsState,
      addedProductsState: event.addedProductsState,
    )));

    on<EventProductCheck>((event, emit) {
      // TODO
    });

    on<EventAddProduct>((event, emit) {
      // TODO
    });

    _cartListsListener = loadCartListsUseCase(
      updateState: (todoProducts, addedProducts) => add(EventUpdateLists(
        todoProductsState: todoProducts,
        addedProductsState: addedProducts,
      )),
    );
  }

  @override
  Future<void> close() {
    _cartListsListener?.cancel();
    return super.close();
  }
}
