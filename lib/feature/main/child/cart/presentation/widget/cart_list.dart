import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/product_item.dart';

final class CartList extends StatelessWidget {
  final IList<Product> products;
  final GlobalKey<SliverAnimatedListState> listKey;
  final void Function(ProductId id, int index) onCheckChange;

  const CartList({
    super.key,
    required this.products,
    required this.listKey,
    required this.onCheckChange,
  });

  @override
  Widget build(BuildContext context) => SliverAnimatedList(
    key: listKey,
    initialItemCount: products.length,
    itemBuilder: (context, index, animation) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: ProductItem(
            key: ValueKey(products[index].id),
            product: products[index],
            onCheckChange: () => onCheckChange(products[index].id, index),
          ),
        ),

        SizedBox(height: context.appTheme.dimensions.padding.small),
      ],
    ),
  );
}
