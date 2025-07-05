import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/check_product_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_effect.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_event.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_state.dart';

final class CartBloc extends Bloc<CartEvent, CartState>
  with BlocPresentationMixin<CartState, CartEffect> {

  CartBloc({
    required TextChangeUseCase textChangeUseCase,
    required LoadCartListsUseCase loadCartListsUseCase,
    required CheckProductUseCase checkProductUseCase,
  }) : super(CartState()) {
    on<EventLoadLists>((event, emit) async {
      final (todo, added) = await loadCartListsUseCase();
      add(EventUpdateLists(todoProductsState: todo, addedProductsState: added));
    });

    on<EventSearchQueryChange>((event, emit) => textChangeUseCase(
      next: event.query,
      errorPredicate: (_) => null,
      update: (textContainer) =>
        emit(state.copyWith(searchQuery: textContainer)),
    ));

    on<EventUpdateLists>((event, emit) => emit(state.copyWith(
      todoProductsState: event.todoProductsState,
      addedProductsState: event.addedProductsState,
    )));

    on<EventProductCheck>((event, emit) async {
      await checkProductUseCase(id: event.id);

      emitPresentation(EffectCheckProduct(
        fromIndex: event.fromIndex,
        toIndex: event.toIndex,
      ));
    });

    on<EventProductUncheck>((event, emit) async {
      await checkProductUseCase(id: event.id);

      emitPresentation(EffectUncheckProduct(
        fromIndex: event.fromIndex,
        toIndex: event.toIndex,
      ));
    });

    on<EventAddProduct>((event, emit) {
      // TODO
    });

    add(EventLoadLists());
  }
}
