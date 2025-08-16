import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_bloc.dart';

sealed class ListFolderEvent {}

final class EventLoadFolder extends ListFolderEvent {}

final class EventLoadList extends ListFolderEvent {}

final class EventSearchQueryChange extends ListFolderEvent {
  final String query;
  EventSearchQueryChange({required this.query});
}

final class EventUpdateListState extends ListFolderEvent {
  final UiState<IList<FolderItem>> itemsState;
  EventUpdateListState({required this.itemsState});
}

final class EventUpdateList extends ListFolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateList({required this.snapshot});
}

final class EventUpdateShownList extends ListFolderEvent {
  final IList<FolderItem> snapshot;
  EventUpdateShownList({required this.snapshot});
}

final class EventStartItemDrag extends ListFolderEvent {
  final FolderItemId id;
  EventStartItemDrag({required this.id});
}

final class EventDeleteFolderItem extends ListFolderEvent {
  final FolderItemId id;
  EventDeleteFolderItem({required this.id});
}

final class EventEditItem extends ListFolderEvent {
  final FolderItem item;
  EventEditItem({required this.item});
}

extension AddListFolderEvent on BuildContext {
  void addListFolderEvent(ListFolderEvent event) =>
    BlocProvider.of<ListFolderBloc>(this).add(event);
}
