import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_checkbox.dart';
import 'package:listy_chef/core/presentation/foundation/app_underlay_action_row.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/images.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';

const _animationDuration = Duration(milliseconds: 300);
const _actionColorEdit = Color(0xFFEDAE49);
const _actionColorDelete = Color(0xFFD1495B);

final class ProductItem extends StatelessWidget {
  final Product product;
  final void Function() onCheckChange;

  const ProductItem({
    super.key,
    required this.product,
    required this.onCheckChange,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<CartBloc, CartState>(
    buildWhen: distinctState((s) => s.draggingProduct),
    builder: (context, state) => ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(context.appTheme.dimensions.radius.small),
      ),
      child: AppUnderlayActionRow(
        isPositionKept: product.id == state.draggingProduct,
        onDragStart: () => context.addCartEvent(EventStartProductDrag(id: product.id)),
        actions: [
          AppUnderlayAction(
            icon: AppImages.loadSvg('ic_edit'),
            backgroundColor: _actionColorEdit,
            onClick: () {}, // TODO
          ),
          AppUnderlayAction(
            icon: AppImages.loadSvg('ic_delete'),
            backgroundColor: _actionColorDelete,
            onClick: () {}, // TODO
          ),
        ],
        child: AnimatedContainer(
          duration: _animationDuration,
          decoration: BoxDecoration(
            color: switch (product.data.isAdded) {
              true => context.appTheme.colors.unique.addedProductBackground,
              false => context.appTheme.colors.unique.todoProductBackground,
            },
          ),
          child: Padding(
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
          ),
        ),
      ),
    ),
  );
}
