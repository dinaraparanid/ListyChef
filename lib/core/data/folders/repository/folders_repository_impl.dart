import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/folders/data_source/folders_data_source.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';

final class FoldersRepositoryImpl implements FoldersRepository {
  final FoldersDataSource _firestoreDataSource;

  FoldersRepositoryImpl({
    required FoldersDataSource firestoreDataSource,
  }) : _firestoreDataSource = firestoreDataSource;

  @override
  Future<IList<Folder>> folders({required Email email}) async {
    return await _firestoreDataSource.folders(email: email);
  }

  @override
  Future<Folder?> folder({required FolderId id}) async {
    return await _firestoreDataSource.folder(id: id);
  }

  @override
  Future<void> addFolder({required FolderData data}) async {
    await _firestoreDataSource.addFolder(data: data);
  }

  @override
  Future<void> removeFolder({required FolderId id}) async {
    await _firestoreDataSource.removeFolder(id: id);
  }

  @override
  Future<void> updateFolder({
    required FolderId id,
    required FolderData newData,
  }) async {
    await _firestoreDataSource.updateFolder(id: id, newData: newData);
  }

  @override
  Future<IList<FolderItem>> folderItems({required FolderId folderId}) async {
    return await _firestoreDataSource.folderItems(folderId: folderId);
  }

  @override
  Future<void> addFolderItem({required FolderItemData data}) async {
    await _firestoreDataSource.addFolderItem(data: data);
  }

  @override
  Future<void> removeFolderItem({required FolderItemId id}) async {
    await _firestoreDataSource.removeFolderItem(id: id);
  }

  @override
  Future<void> updateFolderItem({
    required FolderItemId id,
    required FolderItemData newData,
  }) async {
    await _firestoreDataSource.updateFolderItem(id: id, newData: newData);
  }

  @override
  Future<void> checkFolderItem({required FolderItemId id}) async {
    await _firestoreDataSource.checkFolderItem(id: id);
  }
}
