import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_event.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_added_list_expander.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_check_list.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_check_lists_node.dart';

final class FolderItemCheckLists extends StatelessWidget {
  static const expandDuration = Duration(milliseconds: 300);
  static const movePlaceholder = 1;

  final IList<FolderItem> todoItems;
  final IList<FolderItem> addedItems;
  final bool isTodoAddAnimationInProgress;
  final bool isAddedAddAnimationInProgress;
  final bool isAddedListExpanded;

  const FolderItemCheckLists({
    super.key,
    required this.todoItems,
    required this.addedItems,
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
        sliver: FolderItemCheckList(
          items: todoItems,
          isMoveAnimInProgress: isTodoAddAnimationInProgress,
          listKey: todoListKey,
          onCheckChange: (id, index) => context.addCheckFolderEvent(
            EventFolderItemCheck(
              id: id,
              fromIndex: index,
              toIndex: 0,
            ),
          ),
        ),
      ),

      AddedItemsOpacity(
        sliver: SliverToBoxAdapter(
          child: SizedBox(
            height: context.appTheme.dimensions.padding.extraMedium,
          ),
        ),
      ),

      AddedItemsOpacity(
        sliver: SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: context.appTheme.dimensions.padding.extraMedium,
          ),
          sliver: FolderItemAddedListExpander(
            isAddedListExpanded: isAddedListExpanded,
          ),
        ),
      ),

      AddedItemsOpacity(
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
          sliver: FolderItemCheckList(
            items: addedItems,
            isMoveAnimInProgress: isAddedAddAnimationInProgress,
            listKey: addedListKey,
            onCheckChange: (id, index) => context.addCheckFolderEvent(
              EventFolderItemUncheck(
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

  SliverAnimatedOpacity AddedItemsOpacity({required Widget sliver}) =>
    SliverAnimatedOpacity(
      opacity: addedItems.isEmpty ? 0 : 1,
      duration: expandDuration,
      sliver: sliver,
    );
}
