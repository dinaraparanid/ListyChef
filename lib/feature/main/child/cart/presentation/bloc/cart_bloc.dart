import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/list/product_diff_delegate.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
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
    required ListDifferenceUseCase listDifferenceUseCase,
  }) : super(CartState()) {
    on<EventLoadLists>((event, emit) async {
      final (todo, added) = await loadCartListsUseCase();
      add(EventUpdateListStates(todoProductsState: todo, addedProductsState: added));
    });

    on<EventSearchQueryChange>((event, emit) => textChangeUseCase(
      next: event.query,
      errorPredicate: (_) => null,
      update: (textContainer) {
        emit(state.copyWith(searchQuery: textContainer));

        final oldTodoState = state.shownTodoProductsState;
        final oldTodoList = oldTodoState.getOrNull;
        if (oldTodoList == null) return;

        final oldAddedState = state.shownAddedProductsState;
        final oldAddedList = oldAddedState.getOrNull;
        if (oldAddedList == null) return;

        final newTodoState = state.filteredTodoProductsState;
        final newTodoList = newTodoState.getOrNull;
        if (newTodoList == null) return;

        final newAddedState = state.filteredAddedProductsState;
        final newAddedList = newAddedState.getOrNull;
        if (newAddedList == null) return;

        listDifferenceUseCase(
          delegate: ProductDiffDelegate(
            oldList: oldTodoList,
            newList: newTodoList,
          ),
          onInsert: (index, product) => emitPresentation(
            EffectInsertTodoProduct(index: index, product: product),
          ),
          onRemove: (index, product) => emitPresentation(
            EffectRemoveTodoProduct(index: index, product: product),
          ),
        );

        listDifferenceUseCase(
          delegate: ProductDiffDelegate(
            oldList: oldAddedList,
            newList: newAddedList,
          ),
          onInsert: (index, product) => emitPresentation(
            EffectInsertAddedProduct(index: index, product: product),
          ),
          onRemove: (index, product) => emitPresentation(
            EffectRemoveAddedProduct(index: index, product: product),
          ),
        );
      },
    ));

    on<EventUpdateListStates>((event, emit) => emit(state.copyWith(
      todoProductsState: event.todoProductsState,
      addedProductsState: event.addedProductsState,
      shownTodoProductsState: event.todoProductsState,
      shownAddedProductsState: event.addedProductsState,
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

    on<EventUpdateTodoList>((event, emit) => emit(state.copyWith(
      todoProductsState: event.snapshot.toUiState(),
      shownTodoProductsState: event.snapshot.toUiState(),
    )));

    on<EventUpdateAddedList>((event, emit) => emit(state.copyWith(
      addedProductsState: event.snapshot.toUiState(),
      shownAddedProductsState: event.snapshot.toUiState(),
    )));

    on<EventUpdateShownTodoList>((event, emit) =>
      emit(state.copyWith(shownTodoProductsState: event.snapshot.toUiState())),
    );

    on<EventUpdateShownAddedList>((event, emit) =>
      emit(state.copyWith(shownAddedProductsState: event.snapshot.toUiState())),
    );

    on<EventUpdateTodoAnimationProgress>((event, emit) =>
      emit(state.copyWith(isTodoAddAnimationInProgress: event.isInProgress)),
    );

    on<EventUpdateAddedAnimationProgress>((event, emit) =>
      emit(state.copyWith(isAddedAddAnimationInProgress: event.isInProgress)),
    );

    on<EventAddProduct>((event, emit) {
      // TODO
    });

    add(EventLoadLists());
  }
}
