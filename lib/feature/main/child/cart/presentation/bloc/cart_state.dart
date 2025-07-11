import 'package:dartx/dartx.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/utils/ext/string_ext.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_bloc.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default(TextContainer(value: '', error: null))
    TextContainer<void> searchQuery,

    @Default(UiState.initial())
    UiState<IList<Product>> todoProductsState,

    @Default(UiState.initial())
    UiState<IList<Product>> shownTodoProductsState,

    @Default(UiState.initial())
    UiState<IList<Product>> addedProductsState,

    @Default(UiState.initial())
    UiState<IList<Product>> shownAddedProductsState,

    @Default(false)
    bool isTodoAddAnimationInProgress,

    @Default(false)
    bool isAddedAddAnimationInProgress,

    @Default(true)
    bool isAddedListExpanded,
  }) = _CartState;
}

extension Properties on CartState {
  UiState<IList<Product>> get filteredTodoProductsState =>
    _filterProductsState(initialState: todoProductsState);

  UiState<IList<Product>> get filteredAddedProductsState =>
    _filterProductsState(initialState: addedProductsState);

  UiState<IList<Product>> _filterProductsState({
    required UiState<IList<Product>> initialState,
  }) => initialState.map((list) => list.where(_matchesQuery).toIList());

  bool _matchesQuery(Product product) => switch (searchQuery.value.isBlank) {
    true => true,
    false => product.value.includes(searchQuery.value, ignoreCase: true),
  };
}

extension Getter on BuildContext {
  CartState get cartState =>
    BlocProvider.of<CartBloc>(this, listen: false).state;
}
