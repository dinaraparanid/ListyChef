import 'package:flutter/material.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_checkbox.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';

const _animationDuration = Duration(milliseconds: 300);

final class ProductItem extends StatelessWidget {
  final Product product;
  final void Function() onCheckChange;

  const ProductItem({
    super.key,
    required this.product,
    required this.onCheckChange,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: _animationDuration,
    decoration: BoxDecoration(
      color: switch (product.data.isAdded) {
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
          isChecked: product.data.isAdded,
          onChanged: (_) => onCheckChange(),
        ),

        AnimatedCrossFade(
          duration: _animationDuration,
          crossFadeState: product.data.isAdded
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
          firstChild: Text(
            product.data.value,
            style: context.appTheme.typography.regular.copyWith(
              color: context.appTheme.colors.unique.todoProductText,
              fontWeight: FontWeight.w500,
            ),
          ),
          secondChild: Text(
            product.data.value,
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
