import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_list.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/widget/cart_stateful_list.dart';

final class CartLists extends StatelessWidget {
  final IList<Product> todoProducts;
  final IList<Product> addedProducts;

  const CartLists({
    super.key,
    required this.todoProducts,
    required this.addedProducts,
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
          listKey: todoListKey,
          onCheckChange: (id, index) => BlocProvider
            .of<CartBloc>(context)
            .add(EventProductCheck(
              id: id,
              fromIndex: index,
              toIndex: 0,
            )),
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
          products: addedProducts,
          listKey: addedListKey,
          onCheckChange: (id, index) => BlocProvider
            .of<CartBloc>(context)
            .add(EventProductUncheck(
              id: id,
              fromIndex: index,
              toIndex: 0,
            )),
        ),
      ),
    ],
  );
}
