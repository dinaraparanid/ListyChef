import 'dart:async';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/list/product_diff_delegate.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_event_bus.dart';
import 'package:listy_chef/feature/main/child/cart/domain/check_product_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/delete_product_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/domain/load_cart_lists_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_effect.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_event.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_state.dart';

final class CartBloc extends Bloc<CartEvent, CartState>
  with BlocPresentationMixin<CartState, CartEffect> {

  StreamSubscription<void>? _addProductEventBusSubscription;

  CartBloc({
    required TextChangeUseCase textChangeUseCase,
    required LoadCartListsUseCase loadCartListsUseCase,
    required CheckProductUseCase checkProductUseCase,
    required DeleteProductUseCase deleteProductUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required LoadCartListsEventBus addProductEventBus,
  }) : super(CartState()) {
    void handleListDifferences({
      required IList<Product> oldTodoList,
      required IList<Product> newTodoList,
      required IList<Product> oldAddedList,
      required IList<Product> newAddedList,
    }) {
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
    }

    on<EventLoadLists>((event, emit) async {
      final oldTodoState = state.shownTodoProductsState;
      final oldTodoList = oldTodoState.getOrNull;

      final oldAddedState = state.shownAddedProductsState;
      final oldAddedList = oldAddedState.getOrNull;

      final (newTodoState, newAddedState) = await loadCartListsUseCase();
      final newTodoList = newTodoState.getOrNull;
      final newAddedList = newAddedState.getOrNull;

      if (oldTodoList != null && newTodoList != null &&
          oldAddedList != null && newAddedList != null
      ) {
        handleListDifferences(
          oldTodoList: oldTodoList,
          newTodoList: newTodoList,
          oldAddedList: oldAddedList,
          newAddedList: newAddedList,
        );
      }

      add(EventUpdateListStates(
        todoProductsState: newTodoState,
        addedProductsState: newAddedState,
      ));
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

        handleListDifferences(
          oldTodoList: oldTodoList,
          newTodoList: newTodoList,
          oldAddedList: oldAddedList,
          newAddedList: newAddedList,
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
      await checkProductUseCase(
        id: event.id,
        onError: () => emitPresentation(EffectFailedToCheckProduct()),
      );

      emitPresentation(EffectCheckProduct(
        fromIndex: event.fromIndex,
        toIndex: event.toIndex,
      ));
    });

    on<EventProductUncheck>((event, emit) async {
      await checkProductUseCase(
        id: event.id,
        onError: () => emitPresentation(EffectFailedToUncheckProduct()),
      );

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

    on<EventChangeAddedListExpanded>((event, emit) =>
      emit(state.copyWith(isAddedListExpanded: event.isExpanded)),
    );

    on<EventStartProductDrag>((event, emit) =>
      emit(state.copyWith(draggingProduct: event.id)),
    );

    on<EventDeleteProduct>((event, emit) async {
      await deleteProductUseCase(
        id: event.id,
        onSuccess: () => add(EventLoadLists()),
        onFailure: () => emitPresentation(EffectFailedToDeleteProduct()),
      );
    });

    on<EventEditProduct>((event, emit) {
      emit(state.copyWith(draggingProduct: null));
      emitPresentation(EffectShowUpdateProductMenu(product: event.product));
    });

    add(EventLoadLists());

    _addProductEventBusSubscription = addProductEventBus.listen(
      (_) => add(EventLoadLists())
    );
  }

  @override
  Future<void> close() async {
    await _addProductEventBusSubscription?.cancel();
    return super.close();
  }
}
