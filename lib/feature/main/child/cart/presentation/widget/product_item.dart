import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_checkbox.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_bloc.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_event.dart';

const _animationDuration = Duration(milliseconds: 300);

final class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: _animationDuration,
    decoration: BoxDecoration(
      color: switch (product.isAdded) {
        true => context.appTheme.colors.unique.addedProductBackground,
        false => context.appTheme.colors.unique.todoProductBackground,
      },
      borderRadius: BorderRadius.all(
        Radius.circular(context.appTheme.dimensions.radius.small),
      ),
    ),
    padding: EdgeInsets.symmetric(
      vertical: context.appTheme.dimensions.padding.medium,
      horizontal: context.appTheme.dimensions.padding.small,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppCheckbox(
          isChecked: product.isAdded,
          onChanged: (_) => BlocProvider
            .of<CartBloc>(context)
            .add(EventProductCheck(id: product.id)),
        ),

        AnimatedCrossFade(
          duration: _animationDuration,
          crossFadeState: product.isAdded
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
          firstChild: Text(
            product.value,
            style: context.appTheme.typography.regular.copyWith(
              color: context.appTheme.colors.unique.todoProductText,
              fontWeight: FontWeight.w500,
            ),
          ),
          secondChild: Text(
            product.value,
            style: context.appTheme.typography.regular.copyWith(
              color: context.appTheme.colors.unique.addedProductText,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
      ],
    ),
  );
}
