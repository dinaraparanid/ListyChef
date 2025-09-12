import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/mod.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/list/folder_item_list_node.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/list/folder_item_node.dart';

final class FolderItemList extends StatelessWidget {
  final IList<FolderItem> items;

  const FolderItemList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ListFolderBloc, ListFolderState>(
    buildWhen: distinctState((s) => s.draggingItemId),
    builder: (context, state) => AnimatedList.separated(
      key: listKey,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) => SizeTransition(
        sizeFactor: animation,
        child: ItemWithSpacer(
          context: context,
          index: index,
          draggingItemId: state.draggingItemId,
        ),
      ),
      separatorBuilder: (context, index, animation) => SizeTransition(
        sizeFactor: animation,
        child: SizedBox(height: context.appTheme.dimensions.padding.small),
      ),
      removedSeparatorBuilder: (context, index, animation) => SizeTransition(
        sizeFactor: animation,
        child: SizedBox(height: context.appTheme.dimensions.padding.small),
      ),
    ),
  );

  Widget ItemWithSpacer({
    required BuildContext context,
    required int index,
    required FolderItemId? draggingItemId,
  }) {
    final product = items[index];

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
              onDragStart: () => context.addListFolderEvent(
                EventStartItemDrag(id: product.id),
              ),
              onEdit: () => context.addListFolderEvent(
                EventEditItem(item: product),
              ),
              onDelete: () => context.addListFolderEvent(
                EventDeleteFolderItem(id: product.id),
              ),
            ),
          ),
        ),

        SizedBox(height: context.appTheme.dimensions.padding.small),
      ],
    );
  }
}
