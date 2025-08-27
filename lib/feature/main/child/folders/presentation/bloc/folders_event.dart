import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';

import 'folders_bloc.dart';

sealed class FoldersEvent {}

final class EventLoadFolders extends FoldersEvent {}

final class EventSearchQueryChange extends FoldersEvent {
  final String query;
  EventSearchQueryChange({required this.query});
}

final class EventUpdateFoldersState extends FoldersEvent {
  final UiState<IList<Folder>> foldersState;
  EventUpdateFoldersState({required this.foldersState});
}

final class EventUpdateShownFoldersList extends FoldersEvent {
  final IList<Folder> snapshot;
  EventUpdateShownFoldersList({required this.snapshot});
}

extension AddFoldersEvent on BuildContext {
  void addFoldersEvent(FoldersEvent event) =>
    BlocProvider.of<FoldersBloc>(this).add(event);
}
