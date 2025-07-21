import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_added_list_expander.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_list.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_lists_node.dart';

final class CartLists extends StatelessWidget {
  static const expandDuration = Duration(milliseconds: 300);
  static const movePlaceholder = 1;

  final IList<Product> todoProducts;
  final IList<Product> addedProducts;
  final bool isTodoAddAnimationInProgress;
  final bool isAddedAddAnimationInProgress;
  final bool isAddedListExpanded;

  const CartLists({
    super.key,
    required this.todoProducts,
    required this.addedProducts,
    required this.isTodoAddAnimationInProgress,
    required this.isAddedAddAnimationInProgress,
    required this.isAddedListExpanded,
  });

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverPadding(
        padding: EdgeInsets.symmetric(
          horizontal: context.appTheme.dimensions.padding.extraMedium,
        ),
        sliver: CartList(
          products: todoProducts,
          isMoveAnimInProgress: isTodoAddAnimationInProgress,
          listKey: todoListKey,
          onCheckChange: (id, index) => context.addCartEvent(
            EventProductCheck(
              id: id,
              fromIndex: index,
              toIndex: 0,
            ),
          ),
        ),
      ),

      AddedProductsOpacity(
        sliver: SliverToBoxAdapter(
          child: SizedBox(
            height: context.appTheme.dimensions.padding.extraMedium,
          ),
        ),
      ),

      AddedProductsOpacity(
        sliver: SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: context.appTheme.dimensions.padding.extraMedium,
          ),
          sliver: CartAddedListExpander(isAddedListExpanded: isAddedListExpanded),
        ),
      ),

      AddedProductsOpacity(
        sliver: SliverToBoxAdapter(
          child: SizedBox(
            height: context.appTheme.dimensions.padding.small,
          ),
        ),
      ),

      SliverVisibility(
        visible: isAddedListExpanded,
        sliver: SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: context.appTheme.dimensions.padding.extraMedium,
          ),
          sliver: CartList(
            products: addedProducts,
            isMoveAnimInProgress: isAddedAddAnimationInProgress,
            listKey: addedListKey,
            onCheckChange: (id, index) => context.addCartEvent(
              EventProductUncheck(
                id: id,
                fromIndex: index,
                toIndex: 0,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  SliverAnimatedOpacity AddedProductsOpacity({required Widget sliver}) =>
    SliverAnimatedOpacity(
      opacity: addedProducts.isEmpty ? 0 : 1,
      duration: expandDuration,
      sliver: sliver,
    );
}
