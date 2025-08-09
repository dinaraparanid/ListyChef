import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_purpose.dart';

part 'folder_item_data.freezed.dart';

@freezed
sealed class FolderItemData with _$FolderItemData {
  const factory FolderItemData.check({
    required bool isAdded,
    required String title,
    required FolderId folderId,
    required int timestamp,
  }) = CheckFolderItemData;

  const factory FolderItemData.list({
    required String title,
    required FolderId folderId,
    required int timestamp,
  }) = ListFolderItemData;
}

extension FolderItemDataCast on FolderItemData {
  CheckFolderItemData asCheckData() => this as CheckFolderItemData;
  ListFolderItemData asListData() => this as ListFolderItemData;

  FolderPurpose get purpose => map(
    check: (_) => FolderPurpose.check,
    list: (_) => FolderPurpose.list,
  );
}
