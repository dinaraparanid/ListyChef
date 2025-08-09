import 'package:dartx/dartx.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/utils/ext/string_ext.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/folder_bloc.dart';

part 'folder_state.freezed.dart';

@freezed
abstract class FolderState with _$FolderState {
  const factory FolderState({
    required FolderId folderId,

    @Default(UiState.initial())
    UiState<FolderPurpose> purposeState,

    @Default(TextContainer(value: '', error: null))
    TextContainer<void> searchQuery,

    @Default(UiState.initial())
    UiState<IList<FolderItem>> todoItemsState,

    @Default(UiState.initial())
    UiState<IList<FolderItem>> shownTodoItemsState,

    @Default(UiState.initial())
    UiState<IList<FolderItem>> addedItemsState,

    @Default(UiState.initial())
    UiState<IList<FolderItem>> shownAddedItemsState,

    @Default(false)
    bool isTodoAddAnimationInProgress,

    @Default(false)
    bool isAddedAddAnimationInProgress,

    @Default(true)
    bool isAddedListExpanded,

    @Default(null)
    FolderItemId? draggingItemId,
  }) = _FolderState;
}

extension Properties on FolderState {
  UiState<IList<FolderItem>> get filteredTodoItemsState =>
    _filterItemsState(initialState: todoItemsState);

  UiState<IList<FolderItem>> get filteredAddedItemsState =>
    _filterItemsState(initialState: addedItemsState);

  UiState<IList<FolderItem>> _filterItemsState({
    required UiState<IList<FolderItem>> initialState,
  }) => initialState.mapData((list) => list.where(_matchesQuery).toIList());

  bool _matchesQuery(FolderItem item) => switch (searchQuery.value.isBlank) {
    true => true,
    false => item.data.title.includes(searchQuery.value, ignoreCase: true),
  };
}

extension GetFolderState on BuildContext {
  FolderState get folderState =>
    BlocProvider.of<FolderBloc>(this, listen: false).state;
}
