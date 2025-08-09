import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';

abstract interface class FoldersRepository {
  Future<IList<Folder>> folders({required Email email});

  Future<FolderPurpose?> folderPurpose({required FolderId id});

  Future<void> addFolder({required FolderData data});

  Future<void> removeFolder({required FolderId id});

  Future<void> updateFolder({
    required FolderId id,
    required FolderData newData,
  });

  Future<IList<FolderItem>> folderItems({required FolderId folderId});

  Future<void> addFolderItem({required FolderItemData data});

  Future<void> removeFolderItem({required FolderItemId id});

  Future<void> updateFolderItem({
    required FolderItemId id,
    required FolderItemData newData,
  });

  Future<void> checkFolderItem({required FolderItemId id});
}
