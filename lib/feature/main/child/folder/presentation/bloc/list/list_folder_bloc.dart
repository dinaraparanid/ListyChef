import 'dart:async';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/list/folder_item_diff_delegate.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/folder/domain/delete_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_items_event_bus.dart';
import 'package:listy_chef/core/domain/folders/use_case/load_folder_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_list_folder_items_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_effect.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_event.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_state.dart';

final class ListFolderBloc extends Bloc<ListFolderEvent, ListFolderState>
  with BlocPresentationMixin<ListFolderState, ListFolderEffect> {

  StreamSubscription<void>? _loadFolderItemsEventBusSubscription;

  ListFolderBloc({
    required FolderId folderId,
    required LoadFolderUseCase loadFolderUseCase,
    required TextChangeUseCase textChangeUseCase,
    required LoadListFolderItemsUseCase loadListFolderItemsUseCase,
    required DeleteFolderItemUseCase deleteFolderItemUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required LoadFolderItemsEventBus loadFolderItemsEventBus,
  }) : super(ListFolderState(folderId: folderId)) {
    void handleListDifferences({
      required IList<FolderItem> oldList,
      required IList<FolderItem> newList,
    }) {
      listDifferenceUseCase(
        delegate: FolderItemDiffDelegate(
          oldList: oldList,
          newList: newList,
        ),
        onInsert: (index, item) => emitPresentation(
          EffectInsertFolderItem(index: index, item: item),
        ),
        onRemove: (index, item) => emitPresentation(
          EffectRemoveFolderItem(index: index, item: item),
        ),
      );
    }

    on<EventLoadFolder>((event, emit) async {
      final folderState = await loadFolderUseCase(id: folderId);
      emit(state.copyWith(folderState: folderState));
    });

    on<EventLoadList>((event, emit) async {
      final oldState = state.shownItemsState;
      final oldList = oldState.getOrNull;

      final newState = await loadListFolderItemsUseCase(folderId: state.folderId);
      final newList = newState.getOrNull;

      if (oldList != null && newList != null) {
        handleListDifferences(oldList: oldList, newList: newList);
      }

      add(EventUpdateListState(itemsState: newState));
    });

    on<EventSearchQueryChange>((event, emit) => textChangeUseCase(
      next: event.query,
      errorPredicate: (_) => null,
      update: (textContainer) {
        emit(state.copyWith(searchQuery: textContainer));

        final oldState = state.shownItemsState;
        final oldList = oldState.getOrNull;
        if (oldList == null) return;

        final newState = state.filteredItemsState;
        final newList = newState.getOrNull;
        if (newList == null) return;

        handleListDifferences(oldList: oldList, newList: newList);
      },
    ));

    on<EventUpdateListState>((event, emit) => emit(state.copyWith(
      itemsState: event.itemsState,
      shownItemsState: event.itemsState,
    )));

    on<EventUpdateList>((event, emit) => emit(state.copyWith(
      itemsState: event.snapshot.toUiState(),
      shownItemsState: event.snapshot.toUiState(),
    )));

    on<EventUpdateShownList>((event, emit) =>
      emit(state.copyWith(shownItemsState: event.snapshot.toUiState())),
    );

    on<EventStartItemDrag>((event, emit) =>
      emit(state.copyWith(draggingItemId: event.id)),
    );

    on<EventDeleteFolderItem>((event, emit) async {
      await deleteFolderItemUseCase(
        id: event.id,
        onSuccess: () => add(EventLoadList()),
        onFailure: () => emitPresentation(EffectFailedToDeleteFolderItem()),
      );
    });

    on<EventEditItem>((event, emit) {
      emit(state.copyWith(draggingItemId: null));
      emitPresentation(EffectShowUpdateFolderItemMenu(item: event.item));
    });

    on<EventCopiedToClipboard>((event, emit) =>
      emitPresentation(EffectCopiedToClipboard()),
    );

    add(EventLoadFolder());
    add(EventLoadList());

    _loadFolderItemsEventBusSubscription = loadFolderItemsEventBus.listen(
      (_) => add(EventLoadList())
    );
  }

  @override
  Future<void> close() async {
    await _loadFolderItemsEventBusSubscription?.cancel();
    return super.close();
  }
}
