import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_lists.dart';
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
  Widget build(BuildContext context) => BlocBuilder<CartBloc, CartState>(
    buildWhen: distinctState((s) => s.draggingProduct),
    builder: (context, state) => SliverAnimatedList(
      key: listKey,
      initialItemCount: products.length + CartLists.movePlaceholder,
      itemBuilder: (context, index, animation) => switch (index) {
        0 => SizedBox(),

        1 => Opacity(
          opacity: isMoveAnimInProgress ? 0 : 1,
          child: SizeTransition(
            sizeFactor: animation,
            child: ItemWithSpacer(
              context: context,
              index: index,
              draggingProduct: state.draggingProduct,
            ),
          ),
        ),

        _ => SizeTransition(
          sizeFactor: animation,
          child: ItemWithSpacer(
            context: context,
            index: index,
            draggingProduct: state.draggingProduct,
          ),
        ),
      },
    ),
  );

  Widget ItemWithSpacer({
    required BuildContext context,
    required int index,
    required ProductId? draggingProduct,
  }) {
    final product = products[index - CartLists.movePlaceholder];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: ProductItem(
            key: ValueKey(product.id),
            product: product,
            isPositionKept: product.id == draggingProduct,
            callbacks: ProductItemCallbacks(
              onDragStart: () => context.addCartEvent(
                EventStartProductDrag(id: product.id),
              ),
              onEdit: () => context.addCartEvent(
                EventEditProduct(product: product),
              ),
              onDelete: () => context.addCartEvent(
                EventDeleteProduct(id: product.id),
              ),
              onCheckChange: () => onCheckChange(product.id, index - 1),
            ),
          ),
        ),

        SizedBox(height: context.appTheme.dimensions.padding.small),
      ],
    );
  }
}
