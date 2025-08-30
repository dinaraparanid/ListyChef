import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_mode.dart';

part 'folder_input_state.freezed.dart';

@freezed
abstract class FolderInputState with _$FolderInputState {
  const factory FolderInputState({
    required FolderInputMode mode,

    FolderId? id,
    FolderData? previousData,

    @Default(TextContainer(value: '', error: false))
    TextContainer<bool> title,

    @Default(FolderPurpose.list)
    FolderPurpose purpose,
  }) = _FolderInputState;
}

extension Properties on FolderInputState {
  bool get isConfirmButtonEnabled =>
    title.value.isNotBlank && title.error.not;
}
