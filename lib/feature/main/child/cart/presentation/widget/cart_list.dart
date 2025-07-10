import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/product_item.dart';

final class CartList extends StatelessWidget {
  final IList<Product> products;
  final bool isMoveAnimInProgress;
  final GlobalKey<SliverAnimatedListState> listKey;
  final void Function(ProductId id, int index) onCheckChange;

  const CartList({
    super.key,
    required this.products,
    required this.isMoveAnimInProgress,
    required this.listKey,
    required this.onCheckChange,
  });

  @override
  Widget build(BuildContext context) => SliverAnimatedList(
    key: listKey,
    initialItemCount: products.length + 1,
    itemBuilder: (context, index, animation) => switch (index) {
      0 => SizedBox(),

      1 => Opacity(
        opacity: isMoveAnimInProgress ? 0 : 1,
        child: ItemWithSpacer(context: context, index: index),
      ),

      _ => ItemWithSpacer(context: context, index: index),
    },
  );

  Widget ItemWithSpacer({
    required BuildContext context,
    required int index,
  }) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: double.infinity,
        child: ProductItem(
          key: ValueKey(products[index - 1].id),
          product: products[index - 1],
          onCheckChange: () => onCheckChange(products[index - 1].id, index - 1),
        ),
      ),

      SizedBox(height: context.appTheme.dimensions.padding.small),
    ],
  );
}
