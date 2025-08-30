import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/use_case/load_folder_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folders_event_bus.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/add_folder_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/update_folder_title_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_effect.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_event.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_mode.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_state.dart';

final class FolderInputBloc extends Bloc<FolderInputEvent, FolderInputState>
  with BlocPresentationMixin<FolderInputState, FolderInputEffect> {

  FolderInputBloc({
    required FolderInputMode mode,
    Folder? initialItem,
    required TextChangeUseCase textChangeUseCase,
    required LoadFolderUseCase loadFolderUseCase,
    required AddFolderUseCase addFolderUseCase,
    required UpdateFolderTitleUseCase updateFolderTitleUseCase,
    required LoadFoldersEventBus loadFoldersEventBus,
  }) : super(FolderInputState(
    mode: mode,
    id: initialItem?.id,
    previousData: initialItem?.data,
    title: TextContainer(value: initialItem?.data.title ?? '', error: false),
    purpose: initialItem?.data.purpose,
  )) {
    on<EventUpdatePurpose>((event, emit) =>
      emit(state.copyWith(purpose: event.purpose))
    );

    on<EventUpdateTitle>((event, emit) => textChangeUseCase(
      next: event.title,
      errorPredicate: (text) => text.isBlank,
      update: (textContainer) => emit(state.copyWith(title: textContainer)),
    ));

    on<EventConfirm>((event, emit) async {
      await switch (state.mode) {
        FolderInputMode.create => addFolderUseCase(
          title: state.title.value,
          purpose: state.purpose!,
          onSuccess: () => emitPresentation(EffectSuccess()),
          onError: () => emitPresentation(EffectSuccess()),
        ),

        FolderInputMode.update => updateFolderTitleUseCase(
          id: state.id!,
          previousData: state.previousData!,
          newTitle: state.title.value,
          onSuccess: () => emitPresentation(EffectSuccess()),
          onError: () => emitPresentation(EffectSuccess()),
        ),
      };
    });

    on<EventTriggerRefresh>((event, emit) =>
      loadFoldersEventBus.sendEvent(EventRefresh()),
    );
  }
}
