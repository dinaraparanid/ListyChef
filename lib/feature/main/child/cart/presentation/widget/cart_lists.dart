import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_list.dart';

final _todoListKey = GlobalKey<AnimatedListState>();
final _addedListKey = GlobalKey<AnimatedListState>();

final class CartLists extends StatelessWidget {
  const CartLists({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CartBloc, CartState>(
    builder: (context, state) =>
      switch ((state.todoProductsState, state.addedProductsState)) {
        // TODO: если оба пустые, рисовать заглушку
        (final Data<IList<Product>> todo, final Data<IList<Product>> added) =>
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.appTheme.dimensions.padding.extraMedium,
                ),
                sliver: CartList(
                  products: todo.value,
                  listKey: _todoListKey,
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: context.appTheme.dimensions.padding.extraMedium,
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.appTheme.dimensions.padding.extraMedium,
                ),
                sliver: CartList(
                  products: added.value,
                  listKey: _addedListKey,
                ),
              ),
            ],
          ),

        (_, _) => Text('TODO: Loading'),
      },
  );
}
