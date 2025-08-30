import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_bloc.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_event.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_check_lists.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_node.dart';

final class FolderItemCheckList extends StatelessWidget {
  final IList<FolderItem> items;
  final bool isMoveAnimInProgress;
  final GlobalKey<SliverAnimatedListState> listKey;
  final void Function(FolderItemId id, int index) onCheckChange;

  const FolderItemCheckList({
    super.key,
    required this.items,
    required this.isMoveAnimInProgress,
    required this.listKey,
    required this.onCheckChange,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<CheckFolderBloc, CheckFolderState>(
    buildWhen: distinctState((s) => s.draggingItemId),
    builder: (context, state) => SliverAnimatedList(
      key: listKey,
      initialItemCount: items.length + FolderItemCheckLists.movePlaceholder,
      itemBuilder: (context, index, animation) => switch (index) {
        0 => SizedBox(),

        1 => Opacity(
          opacity: isMoveAnimInProgress ? 0 : 1,
          child: FadeTransition(
            opacity: animation,
            child: ItemWithSpacer(
              context: context,
              index: index,
              draggingItemId: state.draggingItemId,
            ),
          ),
        ),

        _ => FadeTransition(
          opacity: animation,
          child: ItemWithSpacer(
            context: context,
            index: index,
            draggingItemId: state.draggingItemId,
          ),
        ),
      },
    ),
  );

  Widget ItemWithSpacer({
    required BuildContext context,
    required int index,
    required FolderItemId? draggingItemId,
  }) {
    final product = items[index - FolderItemCheckLists.movePlaceholder];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: FolderItemNode(
            item: product,
            isPositionKept: product.id == draggingItemId,
            callbacks: FolderItemNodeCallbacks(
              onDragStart: () => context.addCheckFolderEvent(
                EventStartItemDrag(id: product.id),
              ),
              onEdit: () => context.addCheckFolderEvent(
                EventEditItem(item: product),
              ),
              onDelete: () => context.addCheckFolderEvent(
                EventDeleteFolderItem(id: product.id),
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
