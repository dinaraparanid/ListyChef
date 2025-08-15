import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/list/folder_diff_delegate.dart';
import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_effect.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_event.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_state.dart';

final class FoldersBloc extends Bloc<FoldersEvent, FoldersState>
  with BlocPresentationMixin<FoldersState, FoldersEffect> {

  FoldersBloc({
    required TextChangeUseCase textChangeUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
  }) : super(FoldersState()) {
    void handleListDifferences({
      required IList<Folder> oldList,
      required IList<Folder> newList,
    }) => listDifferenceUseCase(
      delegate: FolderDiffDelegate(
        oldList: oldList,
        newList: newList,
      ),
      onInsert: (index, item) => emitPresentation(
        EffectInsertFolder(index: index, folder: item),
      ),
      onRemove: (index, item) => emitPresentation(
        EffectRemoveFolder(index: index, folder: item),
      ),
    );

    on<EventLoadFolders>((event, emit) {
      // TODO
    });

    on<EventSearchQueryChange>((event, emit) => textChangeUseCase(
      next: event.query,
      errorPredicate: (_) => null,
      update: (textContainer) {
        emit(state.copyWith(searchQuery: textContainer));

        final oldState = state.shownFoldersState;
        final oldList = oldState.getOrNull;
        if (oldList == null) return;

        final newState = state.filteredFoldersState;
        final newList = newState.getOrNull;
        if (newList == null) return;

        handleListDifferences(oldList: oldList, newList: newList);
      },
    ));

    on<EventUpdateFoldersState>((event, emit) => emit(state.copyWith(
      foldersState: event.foldersState,
      shownFoldersState: event.foldersState,
    )));

    on<EventFolderClick>((event, emit) {
      // TODO
    });
  }
}
