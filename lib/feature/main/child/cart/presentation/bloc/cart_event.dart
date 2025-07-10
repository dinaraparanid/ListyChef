import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_bloc.dart';

sealed class CartEvent {}

final class EventLoadLists extends CartEvent {}

final class EventSearchQueryChange extends CartEvent {
  final String query;
  EventSearchQueryChange({required this.query});
}

final class EventUpdateListStates extends CartEvent {
  final UiState<IList<Product>> todoProductsState;
  final UiState<IList<Product>> addedProductsState;

  EventUpdateListStates({
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

final class EventUpdateTodoList extends CartEvent {
  final IList<Product> snapshot;
  EventUpdateTodoList({required this.snapshot});
}

final class EventUpdateAddedList extends CartEvent {
  final IList<Product> snapshot;
  EventUpdateAddedList({required this.snapshot});
}

final class EventUpdateShownTodoList extends CartEvent {
  final IList<Product> snapshot;
  EventUpdateShownTodoList({required this.snapshot});
}

final class EventUpdateShownAddedList extends CartEvent {
  final IList<Product> snapshot;
  EventUpdateShownAddedList({required this.snapshot});
}

final class EventUpdateTodoAnimationProgress extends CartEvent {
  final bool isInProgress;
  EventUpdateTodoAnimationProgress({required this.isInProgress});
}

final class EventUpdateAddedAnimationProgress extends CartEvent {
  final bool isInProgress;
  EventUpdateAddedAnimationProgress({required this.isInProgress});
}

final class EventAddProduct extends CartEvent {}

extension AddCartEvent on BuildContext {
  void addCartEvent(CartEvent event) =>
    BlocProvider.of<CartBloc>(this).add(event);
}