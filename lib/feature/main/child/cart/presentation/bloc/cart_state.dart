import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default(TextContainer(value: '', error: null))
    TextContainer<void> searchQuery,

    @Default(UiState.initial())
    UiState<IList<Product>> todoProductsState,

    @Default(UiState.initial())
    UiState<IList<Product>> addedProductsState,

    @Default(false)
    bool isTodoAddAnimationInProgress,

    @Default(false)
    bool isAddedAddAnimationInProgress,
  }) = _CartState;
}
