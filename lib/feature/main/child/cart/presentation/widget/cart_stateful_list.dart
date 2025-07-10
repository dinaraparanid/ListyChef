import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_effect_handler.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_lists.dart';

final todoListKey = GlobalKey<SliverAnimatedListState>();
final addedListKey = GlobalKey<SliverAnimatedListState>();

final class CartStatefulList extends StatelessWidget {
  const CartStatefulList({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CartBloc, CartState>(
    builder: (context, state) => BlocPresentationListener<CartBloc, CartEffect>(
      listener: (context, effect) async =>
        await onCartEffect(context: context, effect: effect),
      child: switch ((
        state.shownTodoProductsState,
        state.shownAddedProductsState,
      )) {
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
}
