import 'package:flutter/material.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_checkbox.dart';
import 'package:listy_chef/core/presentation/foundation/app_underlay_action_row.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/images.dart';

const _animationDuration = Duration(milliseconds: 300);
const _actionColorEdit = Color(0xFFEDAE49);
const _actionColorDelete = Color(0xFFD1495B);

@immutable
final class ProductItemCallbacks {
  final void Function() onDragStart;
  final void Function() onEdit;
  final void Function() onDelete;
  final void Function() onCheckChange;

  const ProductItemCallbacks({
    required this.onDragStart,
    required this.onEdit,
    required this.onDelete,
    required this.onCheckChange,
  });
}

final class ProductItem extends StatelessWidget {
  final Product product;
  final bool? isPositionKept;
  final ProductItemCallbacks? callbacks;

  const ProductItem({
    super.key,
    required this.product,
    this.isPositionKept,
    this.callbacks,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.all(
      Radius.circular(context.appTheme.dimensions.radius.small),
    ),
    child: switch (callbacks) {
      final ProductItemCallbacks cb => AppUnderlayActionRow(
        isPositionKept: isPositionKept,
        onDragStart: callbacks?.onDragStart,
        actions: [
          AppUnderlayAction(
            icon: AppImages.loadSvg('ic_edit'),
            backgroundColor: _actionColorEdit,
            onClick: cb.onEdit,
          ),
          AppUnderlayAction(
            icon: AppImages.loadSvg('ic_delete'),
            backgroundColor: _actionColorDelete,
            onClick: cb.onDelete,
          ),
        ],
        child: _buildContent(context),
      ),

      null => _buildContent(context),
    },
  );

  Widget _buildContent(BuildContext context) => AnimatedContainer(
    duration: _animationDuration,
    decoration: BoxDecoration(
      color: switch (product.data.isAdded) {
        true => context.appTheme.colors.unique.addedProductBackground,
        false => context.appTheme.colors.unique.todoProductBackground,
      },
    ),
    padding: EdgeInsets.symmetric(
      vertical: context.appTheme.dimensions.padding.medium,
      horizontal: context.appTheme.dimensions.padding.small,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 34,
          height: 34,
          child: AppCheckbox(
            isChecked: product.data.isAdded,
            onChanged: (_) => callbacks?.onCheckChange(),
          ),
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
