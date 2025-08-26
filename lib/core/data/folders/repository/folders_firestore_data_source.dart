import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/data/folders/mapper/folder_item_mapper.dart';
import 'package:listy_chef/core/data/folders/mapper/folder_mapper.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/folders/data_source/folders_data_source.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';
import 'package:listy_chef/core/utils/ext/dynamic_ext.dart';

const _collectionFolders = 'folders';
const _collectionFolderItems = 'folder_items';

final class FoldersFirestoreDataSource implements FoldersDataSource {

  CollectionReference<Map<String, dynamic>> get _foldersCollection =>
    FirebaseFirestore.instance.collection(_collectionFolders);

  CollectionReference<Map<String, dynamic>> get _folderItemsCollection =>
    FirebaseFirestore.instance.collection(_collectionFolderItems);

  @override
  Future<IList<Folder>> folders({required Email email}) =>
    _foldersCollection
      .where(Folder.firestoreFieldEmail, isEqualTo: email.value)
      .get()
      .then((snapshot) => snapshot.toFolderList());

  @override
  Future<Folder?> folder({required FolderId id}) =>
    _foldersCollection
      .doc(id.value)
      .get()
      .then((doc) => doc.toFolder())
      .catchError((e) {
        AppLogger.value.e('Error during getting folder', error: e);
        return null;
      });

  @override
  Future<void> addFolder({required FolderData data}) =>
    _foldersCollection.add(data.toFirestoreData());

  @override
  Future<void> removeFolder({required FolderId id}) =>
    _foldersCollection.doc(id.value).delete();

  @override
  Future<void> updateFolder({
    required FolderId id,
    required FolderData newData,
  }) async {
    final docRef = _foldersCollection.doc(id.value);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.get(docRef).then((doc) {
        transaction.update(docRef, newData.toFirestoreData());
      });
    });
  }

  @override
  Future<IList<FolderItem>> folderItems({required FolderId folderId}) =>
    _folderItemsCollection
      .where(FolderItem.firestoreFieldFolderId, isEqualTo: folderId)
      .orderBy(FolderItem.firestoreFieldTimestamp, descending: true)
      .get()
      .then((snapshot) => snapshot.toFolderItemList());

  @override
  Future<void> addFolderItem({required FolderItemData data}) =>
    _folderItemsCollection.add(data.toFirestoreData());

  @override
  Future<void> removeFolderItem({required FolderItemId id}) =>
    _folderItemsCollection.doc(id.value).delete();

  @override
  Future<void> updateFolderItem({
    required FolderItemId id,
    required FolderItemData newData,
  }) async {
    final docRef = _folderItemsCollection.doc(id.value);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.get(docRef).then((doc) {
        final now = DateTime.now().millisecondsSinceEpoch;
        transaction.update(docRef, newData.toFirestoreData(timestamp: now));
      });
    });
  }

  @override
  Future<void> checkFolderItem({required FolderItemId id}) async {
    final docRef = _folderItemsCollection.doc(id.value);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.get(docRef).then((doc) {
        final nextAdded = asOrNull<bool>(doc[FolderItem.firestoreFieldAdded])?.not ?? false;
        final now = DateTime.now().millisecondsSinceEpoch;

        transaction.update(docRef, {
          FolderItem.firestoreFieldAdded: nextAdded,
          FolderItem.firestoreFieldTimestamp: now,
        });
      });
    });
  }
}
