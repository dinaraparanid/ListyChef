import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/mod.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/list/folder_item_list.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/list/list_folder_effect_handler.dart';

final listKey = GlobalKey<AnimatedListState>();

final class FolderItemListNode extends StatelessWidget {
  const FolderItemListNode({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ListFolderBloc, ListFolderState>(
    builder: (context, state) => BlocPresentationListener<ListFolderBloc, ListFolderEffect>(
      listener: (context, effect) async =>
        await onListFolderEffect(context: context, effect: effect),
      child: switch (state.shownItemsState) {
        final Data<IList<FolderItem>> items when items.value.isNotEmpty =>
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.appTheme.dimensions.padding.extraMedium,
            ),
            child: FolderItemList(items: items.value),
          ),

        final Data<IList<FolderItem>> _ => Text('TODO: Empty stub'),

        _ => Text('TODO: Loading'),
      },
    ),
  );
}
