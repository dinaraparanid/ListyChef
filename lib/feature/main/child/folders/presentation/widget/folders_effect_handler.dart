import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/utils/ext/ilist_ext.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/widget/folder_grid_node.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/widget/folder_node.dart';

const _animDuration = Duration(milliseconds: 300);

Future<void>? onFoldersEffect({
  required BuildContext context,
  required FoldersEffect effect,
}) => switch (effect) {
  EffectInsertFolder() => _onInsertFolder(
    context: context,
    snapshot: context.foldersState.shownFoldersState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.folder,
  ),

  EffectRemoveFolder() => _onRemoteFolder(
    context: context,
    snapshot: context.foldersState.shownFoldersState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.folder,
  ),
};

void _updateShownList({
  required BuildContext context,
  required IList<Folder> newList,
}) => context.addFoldersEvent(EventUpdateShownFoldersList(snapshot: newList));

Future<void>? _onInsertFolder({
  required BuildContext context,
  required IList<Folder> snapshot,
  required int index,
  required Folder item,
}) {
  _updateShownList(context: context, newList: snapshot.insert(index, item));

  gridKey.currentState!.insertItem(
    index,
    duration: _animDuration,
  );

  return null;
}

Future<void>? _onRemoteFolder({
  required BuildContext context,
  required IList<Folder> snapshot,
  required int index,
  required Folder item,
}) {
  _updateShownList(context: context, newList: snapshot.removeAt(index));

  gridKey.currentState!.removeItem(
    index,
    (context, animation) => FadeTransition(
      opacity: animation,
      child: FolderNode(folder: item),
    ),
    duration: _animDuration,
  );

  return null;
}
