import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_item_data.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_item_id.dart';

part 'folder_item.freezed.dart';

@freezed
abstract class FolderItem with _$FolderItem {
  static const firestoreFieldTitle = 'title';
  static const firestoreFieldFolderId = 'folder_id';
  static const firestoreFieldAdded = 'added';
  static const firestoreFieldTimestamp = 'timestamp';

  const factory FolderItem({
    required FolderItemId id,
    required FolderItemData data,
  }) = _FolderItem;
}
