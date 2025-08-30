import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/app_snackbar.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/ext/ilist_ext.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_effect.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_event.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_check_lists.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_check_lists_node.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/widget/check/folder_item_node.dart';
import 'package:listy_chef/feature/main/child/folder_item_input/presentation/bloc/folder_item_input_mode.dart';
import 'package:listy_chef/feature/main/child/folder_item_input/presentation/folder_item_input_menu.dart';

const _moveDuration = Duration(milliseconds: 400);

Future<void>? onCheckFolderEffect({
  required BuildContext context,
  required CheckFolderEffect effect,
}) => switch (effect) {
  EffectCheckFolderItem() => _onFolderItemChecked(
    context: context,
    todoSnapshot: context.checkFolderState.todoItemsState.getOrNull.orEmpty,
    addedSnapshot: context.checkFolderState.addedItemsState.getOrNull.orEmpty,
    fromIndex: effect.fromIndex,
    toIndex: effect.toIndex,
  ),

  EffectUncheckFolderItem() => _onFolderItemUnchecked(
    context: context,
    todoSnapshot: context.checkFolderState.todoItemsState.getOrNull.orEmpty,
    addedSnapshot: context.checkFolderState.addedItemsState.getOrNull.orEmpty,
    fromIndex: effect.fromIndex,
    toIndex: effect.toIndex,
  ),

  EffectInsertTodoFolderItem() => _onInsertTodoFolderItem(
    context: context,
    snapshot: context.checkFolderState.shownTodoItemsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.item,
  ),

  EffectInsertAddedFolderItem() => _onInsertAddedFolderItem(
    context: context,
    snapshot: context.checkFolderState.shownAddedItemsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.item,
  ),

  EffectRemoveTodoFolderItem() => _onRemoveTodoFolderItem(
    context: context,
    snapshot: context.checkFolderState.shownTodoItemsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.item,
  ),

  EffectRemoveAddedFolderItem() => _onRemoveAddedFolderItem(
    context: context,
    snapshot: context.checkFolderState.shownAddedItemsState.getOrNull.orEmpty,
    index: effect.index,
    item: effect.item,
  ),

  EffectShowUpdateFolderItemMenu() => _showUpdateFolderItemMenu(
    context: context,
    item: effect.item,
  ),

  EffectFailedToCheckFolderItem() => _showErrorSnackBar(
    context: context,
    message: context.strings.folder_item_error_check,
  ),

  EffectFailedToUncheckFolderItem() => _showErrorSnackBar(
    context: context,
    message: context.strings.folder_item_error_uncheck,
  ),

  EffectFailedToDeleteFolderItem() => _showErrorSnackBar(
    context: context,
    message: context.strings.folder_item_error_delete,
  ),

  EffectFailedToEditFolderItem() => _showErrorSnackBar(
    context: context,
    message: context.strings.folder_item_error_update,
  ),
};

void _updateTodoAnimation({
  required BuildContext context,
  required bool isInProgress,
}) => context.addCheckFolderEvent(
  EventUpdateTodoAnimationProgress(isInProgress: isInProgress),
);

void _updateAddedAnimation({
  required BuildContext context,
  required bool isInProgress,
}) => context.addCheckFolderEvent(
  EventUpdateAddedAnimationProgress(isInProgress: isInProgress),
);

void _loadLists(BuildContext context) => context.addCheckFolderEvent(EventLoadLists());

void _updateTodoList({
  required BuildContext context,
  required IList<FolderItem> newTodo,
}) => context.addCheckFolderEvent(EventUpdateTodoList(snapshot: newTodo));

void _updateAddedList({
  required BuildContext context,
  required IList<FolderItem> newAdded,
}) => context.addCheckFolderEvent(EventUpdateAddedList(snapshot: newAdded));

void _updateShownTodoList({
  required BuildContext context,
  required IList<FolderItem> newTodo,
}) => context.addCheckFolderEvent(EventUpdateShownTodoList(snapshot: newTodo));

void _updateShownAddedList({
  required BuildContext context,
  required IList<FolderItem> newAdded,
}) => context.addCheckFolderEvent(EventUpdateShownAddedList(snapshot: newAdded));

Future<void> _onFolderItemChecked({
  required BuildContext context,
  required IList<FolderItem> todoSnapshot,
  required IList<FolderItem> addedSnapshot,
  required int fromIndex,
  required int toIndex,
}) async {
  final item = todoSnapshot[fromIndex];

  final reversedItem = item.copyWith(
    data: item.data.asCheckData().copyWith(isAdded: true)
  );

  final itemKey = GlobalKey();

  _updateTodoList(
    context: context,
    newTodo: todoSnapshot.removeAt(fromIndex),
  );

  _updateAddedAnimation(context: context, isInProgress: true);

  todoListKey.currentState!.removeItem(
    fromIndex + FolderItemCheckLists.movePlaceholder,
    (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        width: double.infinity,
        child: Opacity(
          key: itemKey,
          opacity: addedListKey.currentContext == null ? animation.value : 0,
          child: FolderItemNode(item: item),
        ),
      ),
    ),
    duration: _moveDuration,
  );

  _updateAddedList(
    context: context,
    newAdded: addedSnapshot.insert(toIndex, reversedItem),
  );

  addedListKey.currentState?.insertItem(
    toIndex + FolderItemCheckLists.movePlaceholder,
    duration: _moveDuration,
  );

  if (addedListKey.currentContext == null) {
    _updateAddedAnimation(context: context, isInProgress: false);
    _loadLists(context);
    return;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final fromBox = itemKey.currentContext!.findRenderObject() as RenderBox;
    final fromPos = fromBox.localToGlobal(Offset.zero);

    final toBoxList = addedListKey.currentContext?.findRenderObject() as RenderSliverList;
    final firstChildBox = toBoxList.firstChild!;
    final firstChildPos = firstChildBox.localToGlobal(Offset.zero);
    final toPos = Offset(firstChildPos.dx, firstChildPos.dy - fromBox.size.height);

    final entry = OverlayEntry(
      builder: (context) => TweenAnimationBuilder(
        tween: Tween(begin: fromPos, end: toPos),
        duration: _moveDuration,
        curve: Curves.easeInOutQuad,
        builder: (context, offset, child) => Positioned(
          left: context.appTheme.dimensions.padding.extraMedium,
          top: offset.dy,
          child: SizedBox(
            width: fromBox.size.width,
            child: FolderItemNode(item: reversedItem),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
    await Future.delayed(_moveDuration);
    entry.remove();

    if (context.mounted) {
      _updateAddedAnimation(context: context, isInProgress: false);
      _loadLists(context);
    }
  });
}

Future<void> _onFolderItemUnchecked({
  required BuildContext context,
  required IList<FolderItem> todoSnapshot,
  required IList<FolderItem> addedSnapshot,
  required int fromIndex,
  required int toIndex,
}) async {
  final item = addedSnapshot[fromIndex];

  final reversedItem = item.copyWith(
    data: item.data.asCheckData().copyWith(isAdded: false)
  );

  final itemKey = GlobalKey();

  _updateAddedList(
    context: context,
    newAdded: addedSnapshot.removeAt(fromIndex),
  );

  _updateTodoAnimation(context: context, isInProgress: true);

  addedListKey.currentState!.removeItem(
    fromIndex + FolderItemCheckLists.movePlaceholder,
    (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: SizedBox(
        width: double.infinity,
        child: Opacity(
          key: itemKey,
          opacity: 0,
          child: FolderItemNode(item: item),
        ),
      ),
    ),
    duration: _moveDuration,
  );

  _updateTodoList(
    context: context,
    newTodo: todoSnapshot.insert(toIndex, reversedItem),
  );

  todoListKey.currentState!.insertItem(
    toIndex + FolderItemCheckLists.movePlaceholder,
    duration: _moveDuration,
  );

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final fromBox = itemKey.currentContext!.findRenderObject() as RenderBox;
    final fromPos = fromBox.localToGlobal(Offset.zero);

    final toBoxList = todoListKey.currentContext!.findRenderObject() as RenderSliverList;
    final firstChildBox = toBoxList.firstChild!;
    final toPos = firstChildBox.localToGlobal(Offset.zero);

    final entry = OverlayEntry(
      builder: (context) => TweenAnimationBuilder(
        tween: Tween(begin: fromPos, end: toPos),
        duration: _moveDuration,
        curve: Curves.easeInOutQuad,
        builder: (context, offset, child) => Positioned(
          left: context.appTheme.dimensions.padding.extraMedium,
          top: offset.dy,
          child: SizedBox(
            width: fromBox.size.width,
            child: FolderItemNode(item: reversedItem),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
    await Future.delayed(_moveDuration);
    entry.remove();

    if (context.mounted) {
      _updateTodoAnimation(context: context, isInProgress: false);
      _loadLists(context);
    }
  });
}

Future<void>? _onInsertTodoFolderItem({
  required BuildContext context,
  required IList<FolderItem> snapshot,
  required int index,
  required FolderItem item,
}) {
  _updateShownTodoList(
    context: context,
    newTodo: snapshot.insert(index, item),
  );

  todoListKey.currentState!.insertItem(
    index + FolderItemCheckLists.movePlaceholder,
    duration: _moveDuration,
  );

  return null;
}

Future<void>? _onInsertAddedFolderItem({
  required BuildContext context,
  required IList<FolderItem> snapshot,
  required int index,
  required FolderItem item,
}) {
  _updateShownAddedList(
    context: context,
    newAdded: snapshot.insert(index, item),
  );

  addedListKey.currentState!.insertItem(
    index + FolderItemCheckLists.movePlaceholder,
    duration: _moveDuration,
  );

  return null;
}

Future<void>? _onRemoveTodoFolderItem({
  required BuildContext context,
  required IList<FolderItem> snapshot,
  required int index,
  required FolderItem item,
}) {
  _updateShownTodoList(context: context, newTodo: snapshot.removeAt(index));

  todoListKey.currentState!.removeItem(
    index + FolderItemCheckLists.movePlaceholder,
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

Future<void>? _onRemoveAddedFolderItem({
  required BuildContext context,
  required IList<FolderItem> snapshot,
  required int index,
  required FolderItem item,
}) {
  _updateShownAddedList(context: context, newAdded: snapshot.removeAt(index));

  addedListKey.currentState!.removeItem(
    index + FolderItemCheckLists.movePlaceholder,
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
  mode: FolderItemInputMode.update,
  initialItem: item,
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
