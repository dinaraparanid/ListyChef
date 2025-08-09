import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/utils/ext/dynamic_ext.dart';

extension FoldersItemsFromFirestoreMapper on QuerySnapshot<Map<String, dynamic>> {
  IList<FolderItem> toFolderItemList() =>
    docs.mapNotNull((doc) => doc?.toFolderItem()).toIList();
}

extension FolderFromFirestoreMapper on QueryDocumentSnapshot<Map<String, dynamic>> {
  FolderItem? toFolderItem() {
    final data = this.data();
    final id = FolderItemId(this.id);
    final title = asOrNull<String>(data[FolderItem.firestoreFieldTitle]);
    final folderId = asOrNull<FolderId>(data[FolderItem.firestoreFieldFolderId]);
    final isAdded = asOrNull<bool>(data[FolderItem.firestoreFieldAdded]);
    final timestamp = asOrNull<int>(data[FolderItem.firestoreFieldTimestamp]) ?? 0;

    if (title == null || folderId == null) {
      return null;
    }

    return FolderItem(
      id: id,
      data: isAdded != null
        ? FolderItemData.check(
          isAdded: isAdded,
          title: title,
          folderId: folderId,
          timestamp: timestamp,
        )
        : FolderItemData.list(
          title: title,
          folderId: folderId,
          timestamp: timestamp,
        ),
    );
  }
}

extension FolderItemToFirestoreMapper on FolderItemData {
  Map<String, dynamic> toFirestoreData({
    int? timestamp,
  }) => switch (this) {
    final CheckFolderItemData data => {
      FolderItem.firestoreFieldTitle: data.title,
      FolderItem.firestoreFieldFolderId: data.folderId.value,
      FolderItem.firestoreFieldAdded: data.isAdded,
      FolderItem.firestoreFieldTimestamp: timestamp ?? data.timestamp,
    },

    final ListFolderItemData data => {
      FolderItem.firestoreFieldTitle: data.title,
      FolderItem.firestoreFieldFolderId: data.folderId.value,
      FolderItem.firestoreFieldTimestamp: timestamp ?? data.timestamp,
    },
  };
}
