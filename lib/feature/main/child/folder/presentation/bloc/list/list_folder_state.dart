import 'package:dartx/dartx.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/utils/ext/string_ext.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_bloc.dart';

part 'list_folder_state.freezed.dart';

@freezed
abstract class ListFolderState with _$ListFolderState {
  const factory ListFolderState({
    required FolderId folderId,

    @Default(UiState.initial())
    UiState<Folder> folderState,

    @Default(TextContainer(value: '', error: null))
    TextContainer<void> searchQuery,

    @Default(UiState.initial())
    UiState<IList<FolderItem>> itemsState,

    @Default(UiState.initial())
    UiState<IList<FolderItem>> shownItemsState,

    @Default(null)
    FolderItemId? draggingItemId,
  }) = _ListFolderState;
}

extension Properties on ListFolderState {
  UiState<IList<FolderItem>> get filteredItemsState =>
    itemsState.mapData((list) => list.where(_matchesQuery).toIList());

  bool _matchesQuery(FolderItem item) => switch (searchQuery.value.isBlank) {
    true => true,
    false => item.data.title.includes(searchQuery.value, ignoreCase: true),
  };
}

extension GetFolderState on BuildContext {
  ListFolderState get listFolderState =>
    BlocProvider.of<ListFolderBloc>(this, listen: false).state;
}
