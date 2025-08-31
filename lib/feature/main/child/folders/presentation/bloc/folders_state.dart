import 'package:dartx/dartx.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/core/utils/ext/string_ext.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_bloc.dart';

part 'folders_state.freezed.dart';

@freezed
abstract class FoldersState with _$FoldersState {
  const factory FoldersState({
    @Default(TextContainer(value: '', error: null))
    TextContainer<void> searchQuery,

    @Default(UiState.initial())
    UiState<IList<Folder>> foldersState,

    @Default(UiState.initial())
    UiState<IList<Folder>> shownFoldersState,

    @Default(ISet<FolderId>.empty())
    ISet<FolderId> selectedFolders,
  }) = _FoldersState;
}

extension Properties on FoldersState {
  UiState<IList<Folder>> get filteredFoldersState =>
    foldersState.mapData((list) => list.where(_matchesQuery).toIList());

  bool get isFoldersActionsVisible => selectedFolders.isNotEmpty;

  bool get isFolderActionEditEnabled => selectedFolders.length == 1;

  bool _matchesQuery(Folder item) => switch (searchQuery.value.isBlank) {
    true => true,
    false => item.data.title.includes(searchQuery.value, ignoreCase: true),
  };
}

extension GetFoldersState on BuildContext {
  FoldersState get foldersState => BlocProvider.of<FoldersBloc>(this).state;
}
