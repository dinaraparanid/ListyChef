import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/mod.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/check_folder_effect_handler.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_check_lists.dart';

final todoListKey = GlobalKey<SliverAnimatedListState>();
final addedListKey = GlobalKey<SliverAnimatedListState>();

final class FolderItemCheckListsNode extends StatelessWidget {
  const FolderItemCheckListsNode({super.key});

  @override
  Widget build(BuildContext context) =>
    BlocBuilder<CheckFolderBloc, CheckFolderState>(
      builder: (context, state) =>
        BlocPresentationListener<CheckFolderBloc, CheckFolderEffect>(
          listener: (context, effect) async =>
            await onCheckFolderEffect(context: context, effect: effect),
          child: switch ((
            state.shownTodoItemsState,
            state.shownAddedItemsState,
          )) {
            (final Data<IList<FolderItem>> todo, final Data<IList<FolderItem>> added)
            when todo.value.isEmpty && added.value.isEmpty =>
              Text('TODO: Empty stub'),

            (final Data<IList<FolderItem>> todo, final Data<IList<FolderItem>> added) =>
              FolderItemCheckLists(
                todoItems: todo.value,
                addedItems: added.value,
                isTodoAddAnimationInProgress: state.isTodoAddAnimationInProgress,
                isAddedAddAnimationInProgress: state.isAddedAddAnimationInProgress,
                isAddedListExpanded: state.isAddedListExpanded,
              ),

            (_, _) => Text('TODO: Loading'),
          },
        ),
    );
}
