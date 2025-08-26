import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_snackbar.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/ext/ilist_ext.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_effect.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_event.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/list/folder_item_list_node.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/list/folder_item_node.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_mode.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/folder_item_input_menu.dart';

const _moveDuration = Duration(milliseconds: 400);

Future<void>? onListFolderEffect({
  required BuildContext context,
  required ListFolderEffect effect,
}) => switch (effect) {
  EffectInsertFolderItem() => _onInsertFolderItem(
    context: context,
    snapshot: context.listFolderState.shownItemsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.item,
  ),

  EffectRemoveFolderItem() => _onRemoveFolderItem(
    context: context,
    snapshot: context.listFolderState.shownItemsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.item,
  ),

  EffectShowUpdateFolderItemMenu() => _showUpdateFolderItemMenu(
    context: context,
    item: effect.item,
  ),

  EffectFailedToDeleteFolderItem() => _showErrorSnackBar(
    context: context,
    message: context.strings.folder_item_error_delete,
  ),

  EffectFailedToEditFolderItem() => _showErrorSnackBar(
    context: context,
    message: context.strings.folder_item_error_update,
  ),

  EffectCopiedToClipboard() => _showSuccessSnackBar(
    context: context,
    message: context.strings.copied_to_clipboard,
  ),
};

void _updateShownList({
  required BuildContext context,
  required IList<FolderItem> newList,
}) => context.addListFolderEvent(EventUpdateShownList(snapshot: newList));

Future<void>? _onInsertFolderItem({
  required BuildContext context,
  required IList<FolderItem> snapshot,
  required int index,
  required FolderItem item,
}) {
  _updateShownList(
    context: context,
    newList: snapshot.insert(index, item),
  );

  listKey.currentState!.insertItem(index, duration: _moveDuration);

  return null;
}

Future<void>? _onRemoveFolderItem({
  required BuildContext context,
  required IList<FolderItem> snapshot,
  required int index,
  required FolderItem item,
}) {
  _updateShownList(context: context, newList: snapshot.removeAt(index));

  listKey.currentState!.removeItem(
    index,
    (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        width: double.infinity,
        child: FolderItemNode(item: item),
      ),
    ),
    duration: _moveDuration,
  );

  return null;
}

Future<void> _showUpdateFolderItemMenu({
  required BuildContext context,
  required FolderItem item,
}) => showFolderItemInputMenu(
  context: context,
  folderId: item.data.folderId,
  mode: FolderInputMode.update,
  initialItem: item,
);

Future<void> _showSuccessSnackBar({
  required BuildContext context,
  required String message,
}) => showAppSnackBar(
  context: context,
  title: context.strings.success,
  message: message,
  mode: AppSnackBarMode.success,
);

Future<void> _showErrorSnackBar({
  required BuildContext context,
  required String message,
}) => showAppSnackBar(
  context: context,
  title: context.strings.error,
  message: message,
  mode: AppSnackBarMode.error,
);
