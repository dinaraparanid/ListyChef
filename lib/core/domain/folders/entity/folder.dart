import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_data.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';

part 'folder.freezed.dart';

@freezed
abstract class Folder with _$Folder {
  static const firestoreFieldTitle = 'title';
  static const firestoreFieldEmail = 'email';
  static const firestoreFieldPurpose = 'purpose';

  const factory Folder({
    required FolderId id,
    required FolderData data,
  }) = _Folder;
}
