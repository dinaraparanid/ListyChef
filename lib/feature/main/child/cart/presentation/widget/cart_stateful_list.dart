import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_lists.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/product_item.dart';

final todoListKey = GlobalKey<SliverAnimatedListState>();
final addedListKey = GlobalKey<SliverAnimatedListState>();

const _animationDuration = Duration(milliseconds: 300);

final class CartStatefulList extends StatefulWidget {
  const CartStatefulList({super.key});

  @override
  State<StatefulWidget> createState() => _CartStatefulListState();
}

final class _CartStatefulListState extends State<CartStatefulList> {

  @override
  Widget build(BuildContext context) => BlocBuilder<CartBloc, CartState>(
    buildWhen: distinctState((s) => (
      s.todoProductsState,
      s.addedProductsState,
      s.isTodoAddAnimationInProgress,
      s.isAddedAddAnimationInProgress,
    )),
    builder: (context, state) => BlocPresentationListener<CartBloc, CartEffect>(
      listener: (context, effect) async => await switch (effect) {
        EffectCheckProduct() => _onProductChecked(
          context: context,
          todoSnapshot: state.todoProductsState.getOrNull ?? const IList.empty(),
          addedSnapshot: state.addedProductsState.getOrNull ?? const IList.empty(),
          fromIndex: effect.fromIndex,
          toIndex: effect.toIndex,
        ),

        EffectUncheckProduct() => _onProductUnchecked(
          context: context,
          todoSnapshot: state.todoProductsState.getOrNull ?? const IList.empty(),
          addedSnapshot: state.addedProductsState.getOrNull ?? const IList.empty(),
          fromIndex: effect.fromIndex,
          toIndex: effect.toIndex,
        ),
      },
      child: switch ((state.todoProductsState, state.addedProductsState)) {
        // TODO: если оба пустые, рисовать заглушку
        (final Data<IList<Product>> todo, final Data<IList<Product>> added) =>
          CartLists(
            todoProducts: todo.value,
            addedProducts: added.value,
            isTodoAddAnimationInProgress: state.isTodoAddAnimationInProgress,
            isAddedAddAnimationInProgress: state.isAddedAddAnimationInProgress,
          ),

        (_, _) => Text('TODO: Loading'),
      },
    ),
  );

  void _updateTodoAnimation({
    required BuildContext context,
    required bool isInProgress,
  }) => BlocProvider
    .of<CartBloc>(context)
    .add(EventUpdateTodoAnimationProgress(isInProgress: isInProgress));

  void _updateAddedAnimation({
    required BuildContext context,
    required bool isInProgress,
  }) => BlocProvider
    .of<CartBloc>(context)
    .add(EventUpdateAddedAnimationProgress(isInProgress: isInProgress));

  void _loadLists(BuildContext context) =>
    BlocProvider.of<CartBloc>(context).add(EventLoadLists());

  void _updateTodoList({
    required BuildContext context,
    required IList<Product> newTodo,
  }) => BlocProvider
    .of<CartBloc>(context)
    .add(EventUpdateTodoList(snapshot: newTodo));

  void _updateAddedList({
    required BuildContext context,
    required IList<Product> newAdded,
  }) => BlocProvider
    .of<CartBloc>(context)
    .add(EventUpdateAddedList(snapshot: newAdded));

  Future<void> _onProductChecked({
    required BuildContext context,
    required IList<Product> todoSnapshot,
    required IList<Product> addedSnapshot,
    required int fromIndex,
    required int toIndex,
  }) async {
    final item = todoSnapshot[fromIndex];
    final itemKey = GlobalKey();

    _updateTodoList(
      context: context,
      newTodo: todoSnapshot.removeAt(fromIndex),
    );

    _updateAddedAnimation(context: context, isInProgress: true);

    todoListKey.currentState!.removeItem(
      fromIndex,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: SizedBox(
          width: double.infinity,
          child: Opacity(
            key: itemKey,
            opacity: 0,
            child: ProductItem(product: item, onCheckChange: doNothing),
          ),
        ),
      ),
      duration: _animationDuration,
    );

    _updateAddedList(
      context: context,
      newAdded: addedSnapshot.insert(toIndex, item.copyWith(isAdded: true)),
    );

    addedListKey.currentState!.insertItem(toIndex, duration: _animationDuration);
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fromBox = itemKey.currentContext!.findRenderObject() as RenderBox;
      final fromBoxPos = fromBox.localToGlobal(Offset.zero);
      final fromPos = Offset(fromBoxPos.dx, fromBoxPos.dy + fromBox.size.height);

      final toBoxList = addedListKey.currentContext!.findRenderObject() as RenderSliverList;
      final firstChildBox = toBoxList.firstChild!;
      final firstChildPos = firstChildBox.localToGlobal(Offset(0, 0));
      final toPos = Offset(firstChildPos.dx, firstChildPos.dy - fromBox.size.height);

      final entry = OverlayEntry(
        builder: (context) => TweenAnimationBuilder(
          tween: Tween(begin: fromPos, end: toPos),
          duration: _animationDuration,
          builder: (context, offset, child) => Positioned(
            left: 16,
            top: offset.dy,
            child: SizedBox(
              width: fromBox.size.width,
              child: ProductItem(product: item, onCheckChange: () {}),
            ),
          ),
        ),
      );

      Overlay.of(context).insert(entry);
      await Future.delayed(_animationDuration);
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
    final itemKey = GlobalKey();

    _updateAddedList(
      context: context,
      newAdded: addedSnapshot.removeAt(fromIndex),
    );

    _updateTodoAnimation(context: context, isInProgress: true);

    addedListKey.currentState!.removeItem(
      fromIndex,
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
      duration: _animationDuration,
    );

    _updateTodoList(
      context: context,
      newTodo: todoSnapshot.insert(toIndex, item.copyWith(isAdded: false)),
    );

    todoListKey.currentState!.insertItem(toIndex, duration: _animationDuration);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fromBox = itemKey.currentContext!.findRenderObject() as RenderBox;
      final fromPos = fromBox.localToGlobal(Offset.zero);

      final toBoxList = todoListKey.currentContext!.findRenderObject() as RenderSliverList;
      final firstChildBox = toBoxList.firstChild!;
      final toPos = firstChildBox.localToGlobal(Offset(0, 0));

      final entry = OverlayEntry(
        builder: (context) => TweenAnimationBuilder(
          tween: Tween(begin: fromPos, end: toPos),
          duration: _animationDuration,
          builder: (context, offset, child) => Positioned(
            left: 16,
            top: offset.dy,
            child: SizedBox(
              width: fromBox.size.width,
              child: ProductItem(product: item, onCheckChange: () {}),
            ),
          ),
        ),
      );

      Overlay.of(context).insert(entry);
      await Future.delayed(_animationDuration);
      entry.remove();

      if (context.mounted) {
        _updateTodoAnimation(context: context, isInProgress: false);
        _loadLists(context);
      }
    });
  }
}
