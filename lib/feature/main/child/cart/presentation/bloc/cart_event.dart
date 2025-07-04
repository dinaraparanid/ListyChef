import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';

sealed class CartEvent {}

final class EventLoadLists extends CartEvent {}

final class EventSearchQueryChange extends CartEvent {
  final String query;
  EventSearchQueryChange({required this.query});
}

final class EventUpdateLists extends CartEvent {
  final UiState<IList<Product>> todoProductsState;
  final UiState<IList<Product>> addedProductsState;

  EventUpdateLists({
    required this.todoProductsState,
    required this.addedProductsState,
  });
}

final class EventProductCheck extends CartEvent {
  final ProductId id;
  final int fromIndex;
  final int toIndex;

  EventProductCheck({
    required this.id,
    required this.fromIndex,
    required this.toIndex,
  });
}

final class EventProductUncheck extends CartEvent {
  final ProductId id;
  final int fromIndex;
  final int toIndex;

  EventProductUncheck({
    required this.id,
    required this.fromIndex,
    required this.toIndex,
  });
}

final class EventAddProduct extends CartEvent {}
