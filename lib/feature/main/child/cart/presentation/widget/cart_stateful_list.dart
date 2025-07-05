import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
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

  IList<Product> todoProducts = const IList<Product>.empty();
  IList<Product> addedProducts = const IList<Product>.empty();

  @override
  Widget build(BuildContext context) => BlocConsumer<CartBloc, CartState>(
    listenWhen: distinctState((s) => (s.todoProductsState, s.addedProductsState)),
    listener: (context, state) => setState(() {
      todoProducts = state.todoProductsState.getOrNull ?? todoProducts;
      addedProducts = state.addedProductsState.getOrNull ?? addedProducts;
    }),
    buildWhen: distinctState((s) => (s.todoProductsState, s.addedProductsState)),
    builder: (context, state) => BlocPresentationListener<CartBloc, CartEffect>(
      listener: (context, effect) async => switch (effect) {
        EffectCheckProduct() => await _onProductChecked(
          fromIndex: effect.fromIndex,
          toIndex: effect.toIndex,
          onDone: () => _loadLists(context),
        ),

        EffectUncheckProduct() => await _onProductUnchecked(
          fromIndex: effect.fromIndex,
          toIndex: effect.toIndex,
          onDone: () => _loadLists(context),
        ),
      },
      child: switch ((state.todoProductsState, state.addedProductsState)) {
        // TODO: если оба пустые, рисовать заглушку
        (final Data<IList<Product>> _, final Data<IList<Product>> _) =>
          CartLists(todoProducts: todoProducts, addedProducts: addedProducts),

        (_, _) => Text('TODO: Loading'),
      },
    ),
  );

  Future<void> _onProductChecked({
    required int fromIndex,
    required int toIndex,
    required void Function() onDone,
  }) async {
    final item = todoProducts[fromIndex];
    todoProducts = todoProducts.removeAt(fromIndex);

    todoListKey.currentState!.removeItem(
      fromIndex,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: SizedBox(
          width: double.infinity,
          child: ProductItem(product: item, onCheckChange: () {}),
        ),
      ),
      duration: _animationDuration,
    );

    await Future.delayed(_animationDuration);

    setState(() => addedProducts = addedProducts.insert(toIndex, item.copyWith(isAdded: true)));
    addedListKey.currentState!.insertItem(toIndex);

    onDone();
  }

  Future<void> _onProductUnchecked({
    required int fromIndex,
    required int toIndex,
    required void Function() onDone,
  }) async {
    final item = addedProducts[fromIndex];
    addedProducts = addedProducts.removeAt(fromIndex);

    addedListKey.currentState!.removeItem(
      fromIndex,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: SizedBox(
          width: double.infinity,
          child: ProductItem(product: item, onCheckChange: () {}),
        ),
      ),
      duration: _animationDuration,
    );

    await Future.delayed(_animationDuration);

    setState(() => todoProducts = todoProducts.insert(toIndex, item.copyWith(isAdded: false)));
    todoListKey.currentState!.insertItem(toIndex);

    onDone();
  }

  void _loadLists(BuildContext context) =>
    BlocProvider.of<CartBloc>(context).add(EventLoadLists());
}
