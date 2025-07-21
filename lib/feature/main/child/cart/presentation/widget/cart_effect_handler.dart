import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/ilist_ext.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_lists.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_lists_node.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/product_item.dart';

const _moveDuration = Duration(milliseconds: 400);

Future<void>? onCartEffect({
  required BuildContext context,
  required CartEffect effect,
}) => switch (effect) {
  EffectCheckProduct() => _onProductChecked(
    context: context,
    todoSnapshot: context.cartState.todoProductsState.getOrNull.orEmpty,
    addedSnapshot: context.cartState.addedProductsState.getOrNull.orEmpty,
    fromIndex: effect.fromIndex,
    toIndex: effect.toIndex,
  ),

  EffectUncheckProduct() => _onProductUnchecked(
    context: context,
    todoSnapshot: context.cartState.todoProductsState.getOrNull.orEmpty,
    addedSnapshot: context.cartState.addedProductsState.getOrNull.orEmpty,
    fromIndex: effect.fromIndex,
    toIndex: effect.toIndex,
  ),

  EffectInsertTodoProduct() => _onInsertTodoProduct(
    context: context,
    snapshot: context.cartState.shownTodoProductsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.product,
  ),

  EffectInsertAddedProduct() => _onInsertAddedProduct(
    context: context,
    snapshot: context.cartState.shownAddedProductsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.product,
  ),

  EffectRemoveTodoProduct() => _onRemoveTodoProduct(
    context: context,
    snapshot: context.cartState.shownTodoProductsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.product,
  ),

  EffectRemoveAddedProduct() => _onRemoveAddedProduct(
    context: context,
    snapshot: context.cartState.shownAddedProductsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.product,
  ),

  // TODO?
  EffectChangeTodoProduct() => null,
  EffectChangeAddedProduct() => null,
};

void _updateTodoAnimation({
  required BuildContext context,
  required bool isInProgress,
}) => context.addCartEvent(
  EventUpdateTodoAnimationProgress(isInProgress: isInProgress),
);

void _updateAddedAnimation({
  required BuildContext context,
  required bool isInProgress,
}) => context.addCartEvent(
  EventUpdateAddedAnimationProgress(isInProgress: isInProgress),
);

void _loadLists(BuildContext context) => context.addCartEvent(EventLoadLists());

void _updateTodoList({
  required BuildContext context,
  required IList<Product> newTodo,
}) => context.addCartEvent(EventUpdateTodoList(snapshot: newTodo));

void _updateAddedList({
  required BuildContext context,
  required IList<Product> newAdded,
}) => context.addCartEvent(EventUpdateAddedList(snapshot: newAdded));

void _updateShownTodoList({
  required BuildContext context,
  required IList<Product> newTodo,
}) => context.addCartEvent(EventUpdateShownTodoList(snapshot: newTodo));

void _updateShownAddedList({
  required BuildContext context,
  required IList<Product> newAdded,
}) => context.addCartEvent(EventUpdateShownAddedList(snapshot: newAdded));

Future<void> _onProductChecked({
  required BuildContext context,
  required IList<Product> todoSnapshot,
  required IList<Product> addedSnapshot,
  required int fromIndex,
  required int toIndex,
}) async {
  final item = todoSnapshot[fromIndex];
  final reversedItem = item.copyWith(isAdded: true);
  final itemKey = GlobalKey();

  _updateTodoList(
    context: context,
    newTodo: todoSnapshot.removeAt(fromIndex),
  );

  _updateAddedAnimation(context: context, isInProgress: true);

  todoListKey.currentState!.removeItem(
    fromIndex + CartLists.movePlaceholder,
    (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        width: double.infinity,
        child: Opacity(
          key: itemKey,
          opacity: addedListKey.currentContext == null ? animation.value : 0,
          child: ProductItem(product: item, onCheckChange: doNothing),
        ),
      ),
    ),
    duration: _moveDuration,
  );

  _updateAddedList(
    context: context,
    newAdded: addedSnapshot.insert(toIndex, reversedItem),
  );

  addedListKey.currentState?.insertItem(
    toIndex + CartLists.movePlaceholder,
    duration: _moveDuration,
  );

  if (addedListKey.currentContext == null) {
    _updateAddedAnimation(context: context, isInProgress: false);
    _loadLists(context);
    return;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final fromBox = itemKey.currentContext!.findRenderObject() as RenderBox;
    final fromPos = fromBox.localToGlobal(Offset.zero);

    final toBoxList = addedListKey.currentContext?.findRenderObject() as RenderSliverList;
    final firstChildBox = toBoxList.firstChild!;
    final firstChildPos = firstChildBox.localToGlobal(Offset.zero);
    final toPos = Offset(firstChildPos.dx, firstChildPos.dy - fromBox.size.height);

    final entry = OverlayEntry(
      builder: (context) => TweenAnimationBuilder(
        tween: Tween(begin: fromPos, end: toPos),
        duration: _moveDuration,
        curve: Curves.easeInOutQuad,
        builder: (context, offset, child) => Positioned(
          left: context.appTheme.dimensions.padding.extraMedium,
          top: offset.dy,
          child: SizedBox(
            width: fromBox.size.width,
            child: ProductItem(product: reversedItem, onCheckChange: doNothing),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
    await Future.delayed(_moveDuration);
    entry.remove();

    if (context.mounted) {
      _updateAddedAnimation(context: context, isInProgress: false);
      _loadLists(context);
    }
  });
}

Future<void> _onProductUnchecked({
  required BuildContext context,
  required IList<Product> todoSnapshot,
  required IList<Product> addedSnapshot,
  required int fromIndex,
  required int toIndex,
}) async {
  final item = addedSnapshot[fromIndex];
  final reversedItem = item.copyWith(isAdded: false);
  final itemKey = GlobalKey();

  _updateAddedList(
    context: context,
    newAdded: addedSnapshot.removeAt(fromIndex),
  );

  _updateTodoAnimation(context: context, isInProgress: true);

  addedListKey.currentState!.removeItem(
    fromIndex + CartLists.movePlaceholder,
    (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        key: itemKey,
        width: double.infinity,
        child: Opacity(
          opacity: 0,
          child: ProductItem(product: item, onCheckChange: doNothing),
        ),
      ),
    ),
    duration: _moveDuration,
  );

  _updateTodoList(
    context: context,
    newTodo: todoSnapshot.insert(toIndex, reversedItem),
  );

  todoListKey.currentState!.insertItem(
    toIndex + CartLists.movePlaceholder,
    duration: _moveDuration,
  );

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final fromBox = itemKey.currentContext!.findRenderObject() as RenderBox;
    final fromPos = fromBox.localToGlobal(Offset.zero);

    final toBoxList = todoListKey.currentContext!.findRenderObject() as RenderSliverList;
    final firstChildBox = toBoxList.firstChild!;
    final toPos = firstChildBox.localToGlobal(Offset.zero);

    final entry = OverlayEntry(
      builder: (context) => TweenAnimationBuilder(
        tween: Tween(begin: fromPos, end: toPos),
        duration: _moveDuration,
        curve: Curves.easeInOutQuad,
        builder: (context, offset, child) => Positioned(
          left: context.appTheme.dimensions.padding.extraMedium,
          top: offset.dy,
          child: SizedBox(
            width: fromBox.size.width,
            child: ProductItem(product: reversedItem, onCheckChange: doNothing),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
    await Future.delayed(_moveDuration);
    entry.remove();

    if (context.mounted) {
      _updateTodoAnimation(context: context, isInProgress: false);
      _loadLists(context);
    }
  });
}

Future<void>? _onInsertTodoProduct({
  required BuildContext context,
  required IList<Product> snapshot,
  required int index,
  required Product item,
}) {
  _updateShownTodoList(
    context: context,
    newTodo: snapshot.insert(index, item),
  );

  todoListKey.currentState!.insertItem(
    index + CartLists.movePlaceholder,
    duration: _moveDuration,
  );

  return null;
}

Future<void>? _onInsertAddedProduct({
  required BuildContext context,
  required IList<Product> snapshot,
  required int index,
  required Product item,
}) {
  _updateShownAddedList(
    context: context,
    newAdded: snapshot.insert(index, item),
  );

  addedListKey.currentState!.insertItem(
    index + CartLists.movePlaceholder,
    duration: _moveDuration,
  );

  return null;
}

Future<void>? _onRemoveTodoProduct({
  required BuildContext context,
  required IList<Product> snapshot,
  required int index,
  required Product item,
}) {
  _updateShownTodoList(context: context, newTodo: snapshot.removeAt(index));

  todoListKey.currentState!.removeItem(
    index + CartLists.movePlaceholder,
    (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        width: double.infinity,
        child: ProductItem(product: item, onCheckChange: doNothing),
      ),
    ),
    duration: _moveDuration,
  );

  return null;
}

Future<void>? _onRemoveAddedProduct({
  required BuildContext context,
  required IList<Product> snapshot,
  required int index,
  required Product item,
}) {
  _updateShownAddedList(context: context, newAdded: snapshot.removeAt(index));

  addedListKey.currentState!.removeItem(
    index + CartLists.movePlaceholder,
    (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        width: double.infinity,
        child: ProductItem(product: item, onCheckChange: doNothing),
      ),
    ),
    duration: _moveDuration,
  );

  return null;
}
