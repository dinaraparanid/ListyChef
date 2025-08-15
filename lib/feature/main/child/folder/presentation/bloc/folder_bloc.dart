import 'dart:async';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/list/folder_item_diff_delegate.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:listy_chef/feature/main/child/folder/domain/check_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/delete_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_check_folder_items_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_items_event_bus.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/folder_effect.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/folder_event.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/folder_state.dart';

final class FolderBloc extends Bloc<FolderEvent, FolderState>
  with BlocPresentationMixin<FolderState, FolderEffect> {

  StreamSubscription<void>? _loadFolderItemsEventBusSubscription;

  FolderBloc({
    required FolderId folderId,
    required TextChangeUseCase textChangeUseCase,
    required LoadCheckFolderItemsUseCase loadCheckFolderItemsUseCase,
    required CheckFolderItemUseCase checkFolderItemUseCase,
    required DeleteFolderItemUseCase deleteFolderItemUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required LoadFolderItemsEventBus loadFolderItemsEventBus,
  }) : super(FolderState(folderId: folderId)) {
    void handleListDifferences({
      required IList<FolderItem> oldTodoList,
      required IList<FolderItem> newTodoList,
      required IList<FolderItem> oldAddedList,
      required IList<FolderItem> newAddedList,
    }) {
      listDifferenceUseCase(
        delegate: FolderItemDiffDelegate(
          oldList: oldTodoList,
          newList: newTodoList,
        ),
        onInsert: (index, item) => emitPresentation(
          EffectInsertTodoFolderItem(index: index, item: item),
        ),
        onRemove: (index, item) => emitPresentation(
          EffectRemoveTodoFolderItem(index: index, item: item),
        ),
      );

      listDifferenceUseCase(
        delegate: FolderItemDiffDelegate(
          oldList: oldAddedList,
          newList: newAddedList,
        ),
        onInsert: (index, item) => emitPresentation(
          EffectInsertAddedFolderItem(index: index, item: item),
        ),
        onRemove: (index, item) => emitPresentation(
          EffectRemoveAddedFolderItem(index: index, item: item),
        ),
      );
    }

    on<EventLoadLists>((event, emit) async {
      final oldTodoState = state.shownTodoItemsState;
      final oldTodoList = oldTodoState.getOrNull;

      final oldAddedState = state.shownAddedItemsState;
      final oldAddedList = oldAddedState.getOrNull;

      final (newTodoState, newAddedState) = await loadCheckFolderItemsUseCase(
        folderId: state.folderId,
      );

      final newTodoList = newTodoState.getOrNull;
      final newAddedList = newAddedState.getOrNull;

      if (oldTodoList != null && newTodoList != null &&
          oldAddedList != null && newAddedList != null
      ) {
        handleListDifferences(
          oldTodoList: oldTodoList,
          newTodoList: newTodoList,
          oldAddedList: oldAddedList,
          newAddedList: newAddedList,
        );
      }

      add(EventUpdateListStates(
        todoItemsState: newTodoState,
        addedItemsState: newAddedState,
      ));
    });

    on<EventSearchQueryChange>((event, emit) => textChangeUseCase(
      next: event.query,
      errorPredicate: (_) => null,
      update: (textContainer) {
        emit(state.copyWith(searchQuery: textContainer));

        final oldTodoState = state.shownTodoItemsState;
        final oldTodoList = oldTodoState.getOrNull;
        if (oldTodoList == null) return;

        final oldAddedState = state.shownAddedItemsState;
        final oldAddedList = oldAddedState.getOrNull;
        if (oldAddedList == null) return;

        final newTodoState = state.filteredTodoItemsState;
        final newTodoList = newTodoState.getOrNull;
        if (newTodoList == null) return;

        final newAddedState = state.filteredAddedItemsState;
        final newAddedList = newAddedState.getOrNull;
        if (newAddedList == null) return;

        handleListDifferences(
          oldTodoList: oldTodoList,
          newTodoList: newTodoList,
          oldAddedList: oldAddedList,
          newAddedList: newAddedList,
        );
      },
    ));

    on<EventUpdateListStates>((event, emit) => emit(state.copyWith(
      todoItemsState: event.todoItemsState,
      addedItemsState: event.addedItemsState,
      shownTodoItemsState: event.todoItemsState,
      shownAddedItemsState: event.addedItemsState,
    )));

    on<EventFolderItemCheck>((event, emit) async {
      await checkFolderItemUseCase(
        id: event.id,
        onError: () => emitPresentation(EffectFailedToCheckFolderItem()),
      );

      emitPresentation(EffectCheckFolderItem(
        fromIndex: event.fromIndex,
        toIndex: event.toIndex,
      ));
    });

    on<EventFolderItemUncheck>((event, emit) async {
      await checkFolderItemUseCase(
        id: event.id,
        onError: () => emitPresentation(EffectFailedToUncheckFolderItem()),
      );

      emitPresentation(EffectUncheckFolderItem(
        fromIndex: event.fromIndex,
        toIndex: event.toIndex,
      ));
    });

    on<EventUpdateTodoList>((event, emit) => emit(state.copyWith(
      todoItemsState: event.snapshot.toUiState(),
      shownTodoItemsState: event.snapshot.toUiState(),
    )));

    on<EventUpdateAddedList>((event, emit) => emit(state.copyWith(
      addedItemsState: event.snapshot.toUiState(),
      shownAddedItemsState: event.snapshot.toUiState(),
    )));

    on<EventUpdateShownTodoList>((event, emit) =>
      emit(state.copyWith(shownTodoItemsState: event.snapshot.toUiState())),
    );

    on<EventUpdateShownAddedList>((event, emit) =>
      emit(state.copyWith(shownAddedItemsState: event.snapshot.toUiState())),
    );

    on<EventUpdateTodoAnimationProgress>((event, emit) =>
      emit(state.copyWith(isTodoAddAnimationInProgress: event.isInProgress)),
    );

    on<EventUpdateAddedAnimationProgress>((event, emit) =>
      emit(state.copyWith(isAddedAddAnimationInProgress: event.isInProgress)),
    );

    on<EventChangeAddedListExpanded>((event, emit) =>
      emit(state.copyWith(isAddedListExpanded: event.isExpanded)),
    );

    on<EventStartItemDrag>((event, emit) =>
      emit(state.copyWith(draggingItemId: event.id)),
    );

    on<EventDeleteFolderItem>((event, emit) async {
      await deleteFolderItemUseCase(
        id: event.id,
        onSuccess: () => add(EventLoadLists()),
        onFailure: () => emitPresentation(EffectFailedToDeleteFolderItem()),
      );
    });

    on<EventEditItem>((event, emit) {
      emit(state.copyWith(draggingItemId: null));
      emitPresentation(EffectShowUpdateFolderItemMenu(item: event.item));
    });

    add(EventLoadLists());

    _loadFolderItemsEventBusSubscription = loadFolderItemsEventBus.listen(
      (_) => add(EventLoadLists())
    );
  }

  @override
  Future<void> close() async {
    await _loadFolderItemsEventBusSubscription?.cancel();
    return super.close();
  }
}
