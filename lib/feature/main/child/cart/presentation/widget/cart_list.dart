import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/product_item.dart';

final class CartList extends StatelessWidget {
  final IList<Product> products;
  final GlobalKey<AnimatedListState> listKey;

  const CartList({
    super.key,
    required this.products,
    required this.listKey,
  });

  @override
  Widget build(BuildContext context) => SliverAnimatedList(
    key: listKey,
    initialItemCount: products.length,
    itemBuilder: (context, index, animation) => ProductItem(
      key: ValueKey(products[index].id),
      product: products[index]
    ),
  );
}
