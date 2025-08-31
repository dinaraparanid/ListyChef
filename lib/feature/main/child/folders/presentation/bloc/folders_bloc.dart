import 'dart:async';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:dartx/dartx.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/list/folder_diff_delegate.dart';
import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folders_event_bus.dart';
import 'package:listy_chef/feature/main/child/folders/domain/delete_folders_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/domain/load_folders_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_effect.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_event.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_state.dart';

final class FoldersBloc extends Bloc<FoldersEvent, FoldersState>
  with BlocPresentationMixin<FoldersState, FoldersEffect> {

  StreamSubscription<void>? _loadFoldersEventBusSubscription;

  FoldersBloc({
    required TextChangeUseCase textChangeUseCase,
    required LoadFoldersUseCase loadFoldersUseCase,
    required DeleteFoldersUseCase deleteFoldersUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required LoadFoldersEventBus loadFoldersEventBus,
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

    on<EventLoadFolders>((event, emit) async {
      final oldState = state.shownFoldersState;
      final oldList = oldState.getOrNull;

      final newState = await loadFoldersUseCase();
      final newList = newState.getOrNull;

      if (oldList != null && newList != null) {
        handleListDifferences(
          oldList: oldList,
          newList: newList,
        );
      }

      add(EventUpdateFoldersState(foldersState: newState));
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

    on<EventUpdateShownFoldersList>((event, emit) => emit(state.copyWith(
      shownFoldersState: event.snapshot.toUiState(),
    )));

    on<EventSelectFolder>((event, emit) => emit(state.copyWith(
      selectedFolders: state.selectedFolders.contains(event.folderId)
        ? state.selectedFolders.remove(event.folderId)
        : state.selectedFolders.add(event.folderId),
    )));

    on<EventCancelSelection>((event, emit) =>
      emit(state.copyWith(selectedFolders: const ISet.empty()))
    );

    on<EventDeleteFolders>((event, emit) async {
      await deleteFoldersUseCase(
        ids: state.selectedFolders,
        onSuccess: () => add(EventCancelSelection()),
        onFailure: () => emitPresentation(EffectFailedToDeleteFolders()),
      );

      add(EventLoadFolders());
    });

    on<EventEditFolder>((event, emit) {
      final folders = state.foldersState.getOrNull;
      final selectedFolderId = state.selectedFolders.firstOrNull;

      if (folders == null || selectedFolderId == null) {
        return;
      }

      final folder = folders.firstOrNullWhere((f) => f.id == selectedFolderId);

      if (folder != null) {
        emitPresentation(EffectShowUpdateFolderMenu(item: folder));
        add(EventCancelSelection());
      }
    });

    add(EventLoadFolders());

    _loadFoldersEventBusSubscription = loadFoldersEventBus.listen(
      (_) => add(EventLoadFolders()),
    );
  }

  @override
  Future<void> close() async {
    await _loadFoldersEventBusSubscription?.cancel();
    return super.close();
  }
}
