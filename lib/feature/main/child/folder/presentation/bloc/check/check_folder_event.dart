import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_bloc.dart';

sealed class CheckFolderEvent {}

final class EventLoadFolder extends CheckFolderEvent {}

final class EventLoadLists extends CheckFolderEvent {}

final class EventSearchQueryChange extends CheckFolderEvent {
  final String query;
  EventSearchQueryChange({required this.query});
}

final class EventUpdateListStates extends CheckFolderEvent {
  final UiState<IList<FolderItem>> todoItemsState;
  final UiState<IList<FolderItem>> addedItemsState;

  EventUpdateListStates({
    required this.todoItemsState,
    required this.addedItemsState,
  });
}

final class EventFolderItemCheck extends CheckFolderEvent {
  final FolderItemId id;
  final int fromIndex;
  final int toIndex;

  EventFolderItemCheck({
    required this.id,
    required this.fromIndex,
    required this.toIndex,
  });
}

final class EventFolderItemUncheck extends CheckFolderEvent {
  final FolderItemId id;
  final int fromIndex;
  final int toIndex;

  EventFolderItemUncheck({
    required this.id,
    required this.fromIndex,
    required this.toIndex,
  });
}

final class EventUpdateTodoList extends CheckFolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateTodoList({required this.snapshot});
}

final class EventUpdateAddedList extends CheckFolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateAddedList({required this.snapshot});
}

final class EventUpdateShownTodoList extends CheckFolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateShownTodoList({required this.snapshot});
}

final class EventUpdateShownAddedList extends CheckFolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateShownAddedList({required this.snapshot});
}

final class EventUpdateTodoAnimationProgress extends CheckFolderEvent {
  final bool isInProgress;
  EventUpdateTodoAnimationProgress({required this.isInProgress});
}

final class EventUpdateAddedAnimationProgress extends CheckFolderEvent {
  final bool isInProgress;
  EventUpdateAddedAnimationProgress({required this.isInProgress});
}

final class EventChangeAddedListExpanded extends CheckFolderEvent {
  final bool isExpanded;
  EventChangeAddedListExpanded({required this.isExpanded});
}

final class EventStartItemDrag extends CheckFolderEvent {
  final FolderItemId id;
  EventStartItemDrag({required this.id});
}

final class EventDeleteFolderItem extends CheckFolderEvent {
  final FolderItemId id;
  EventDeleteFolderItem({required this.id});
}

final class EventEditItem extends CheckFolderEvent {
  final FolderItem item;
  EventEditItem({required this.item});
}

extension AddCheckFolderEvent on BuildContext {
  void addCheckFolderEvent(CheckFolderEvent event) =>
    BlocProvider.of<CheckFolderBloc>(this).add(event);
}
