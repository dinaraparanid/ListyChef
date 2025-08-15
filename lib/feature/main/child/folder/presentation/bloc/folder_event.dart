import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/folder_bloc.dart';

sealed class FolderEvent {}

final class EventLoadLists extends FolderEvent {}

final class EventSearchQueryChange extends FolderEvent {
  final String query;
  EventSearchQueryChange({required this.query});
}

final class EventUpdateListStates extends FolderEvent {
  final UiState<IList<FolderItem>> todoItemsState;
  final UiState<IList<FolderItem>> addedItemsState;

  EventUpdateListStates({
    required this.todoItemsState,
    required this.addedItemsState,
  });
}

final class EventFolderItemCheck extends FolderEvent {
  final FolderItemId id;
  final int fromIndex;
  final int toIndex;

  EventFolderItemCheck({
    required this.id,
    required this.fromIndex,
    required this.toIndex,
  });
}

final class EventFolderItemUncheck extends FolderEvent {
  final FolderItemId id;
  final int fromIndex;
  final int toIndex;

  EventFolderItemUncheck({
    required this.id,
    required this.fromIndex,
    required this.toIndex,
  });
}

final class EventUpdateTodoList extends FolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateTodoList({required this.snapshot});
}

final class EventUpdateAddedList extends FolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateAddedList({required this.snapshot});
}

final class EventUpdateShownTodoList extends FolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateShownTodoList({required this.snapshot});
}

final class EventUpdateShownAddedList extends FolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateShownAddedList({required this.snapshot});
}

final class EventUpdateTodoAnimationProgress extends FolderEvent {
  final bool isInProgress;
  EventUpdateTodoAnimationProgress({required this.isInProgress});
}

final class EventUpdateAddedAnimationProgress extends FolderEvent {
  final bool isInProgress;
  EventUpdateAddedAnimationProgress({required this.isInProgress});
}

final class EventChangeAddedListExpanded extends FolderEvent {
  final bool isExpanded;
  EventChangeAddedListExpanded({required this.isExpanded});
}

final class EventStartItemDrag extends FolderEvent {
  final FolderItemId id;
  EventStartItemDrag({required this.id});
}

final class EventDeleteFolderItem extends FolderEvent {
  final FolderItemId id;
  EventDeleteFolderItem({required this.id});
}

final class EventEditItem extends FolderEvent {
  final FolderItem item;
  EventEditItem({required this.item});
}

extension AddFolderEvent on BuildContext {
  void addFolderEvent(FolderEvent event) =>
    BlocProvider.of<FolderBloc>(this).add(event);
}
