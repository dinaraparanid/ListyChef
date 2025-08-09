import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_mode.dart';

part 'folder_item_input_state.freezed.dart';

@freezed
abstract class FolderItemInputState with _$FolderItemInputState {
  const factory FolderItemInputState({
    required FolderInputMode mode,
    required FolderId folderId,

    FolderItemId? id,
    FolderItemData? previousData,

    @Default(TextContainer(value: '', error: false))
    TextContainer<bool> title,

    FolderPurpose? purpose,
  }) = _FolderItemInputState;
}

extension Properties on FolderItemInputState {
  bool get isConfirmButtonEnabled =>
    title.value.isNotBlank && title.error.not && purpose != null;
}
