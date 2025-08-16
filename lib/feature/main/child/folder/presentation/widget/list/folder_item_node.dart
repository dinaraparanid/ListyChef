import 'package:flutter/material.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_underlay_action_row.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/images.dart';

const _animationDuration = Duration(milliseconds: 300);
const _actionColorEdit = Color(0xFFEDAE49);
const _actionColorDelete = Color(0xFFD1495B);

@immutable
final class FolderItemNodeCallbacks {
  final void Function() onDragStart;
  final void Function() onEdit;
  final void Function() onDelete;

  const FolderItemNodeCallbacks({
    required this.onDragStart,
    required this.onEdit,
    required this.onDelete,
  });
}

final class FolderItemNode extends StatelessWidget {
  final FolderItem item;
  final bool? isPositionKept;
  final FolderItemNodeCallbacks? callbacks;

  const FolderItemNode({
    super.key,
    required this.item,
    this.isPositionKept,
    this.callbacks,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.all(
      Radius.circular(context.appTheme.dimensions.radius.small),
    ),
    child: switch (callbacks) {
      final FolderItemNodeCallbacks cb => AppUnderlayActionRow(
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

  Widget _buildContent(BuildContext context) {
    final data = item.data.asListData();

    return AnimatedContainer(
      duration: _animationDuration,
      decoration: BoxDecoration(
        color: context.appTheme.colors.unique.todoProductBackground,
      ),
      padding: EdgeInsets.symmetric(
        vertical: context.appTheme.dimensions.padding.medium,
        horizontal: context.appTheme.dimensions.padding.small,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data.title,
            style: context.appTheme.typography.regular.copyWith(
              color: context.appTheme.colors.unique.todoProductText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
