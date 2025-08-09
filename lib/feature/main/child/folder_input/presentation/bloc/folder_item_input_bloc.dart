import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_items_event_bus.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/add_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/update_folder_item_title_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_effect.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_item_input_event.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_mode.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_item_input_state.dart';

final class FolderItemInputBloc extends Bloc<FolderItemInputEvent, FolderItemInputState>
  with BlocPresentationMixin<FolderItemInputState, FolderInputEffect> {

  FolderItemInputBloc({
    required FolderInputMode mode,
    required FolderId folderId,
    FolderItem? initialItem,
    required TextChangeUseCase textChangeUseCase,
    required AddFolderItemUseCase addFolderItemUseCase,
    required UpdateFolderItemTitleUseCase updateFolderItemTitleUseCase,
    required LoadFolderItemsEventBus loadFolderItemsEventBus,
  }) : super(FolderItemInputState(
    mode: mode,
    folderId: folderId,
    id: initialItem?.id,
    previousData: initialItem?.data,
    title: TextContainer(value: initialItem?.data.title ?? '', error: false),
    purpose: initialItem?.data.purpose,
  )) {
    on<EventUpdateTitle>((event, emit) => textChangeUseCase(
      next: event.title,
      errorPredicate: (text) => text.isBlank,
      update: (textContainer) => emit(state.copyWith(title: textContainer)),
    ));

    on<EventConfirm>((event, emit) async {
      await switch (state.mode) {
        FolderInputMode.create => addFolderItemUseCase(
          title: state.title.value,
          folderId: state.folderId,
          purpose: state.purpose!,
          onSuccess: () => emitPresentation(EffectSuccess()),
          onError: () => emitPresentation(EffectSuccess()),
        ),

        FolderInputMode.update => updateFolderItemTitleUseCase(
          id: state.id!,
          previousData: state.previousData!,
          newTitle: state.title.value,
          onSuccess: () => emitPresentation(EffectSuccess()),
          onError: () => emitPresentation(EffectSuccess()),
        ),
      };
    });

    on<EventTriggerRefresh>((event, emit) =>
      loadFolderItemsEventBus.sendEvent(EventRefresh()),
    );
  }
}
