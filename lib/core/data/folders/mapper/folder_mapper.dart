import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/utils/ext/dynamic_ext.dart';
import 'package:listy_chef/core/utils/ext/general.dart';

extension FoldersFromFirestoreMapper on QuerySnapshot<Map<String, dynamic>> {
  IList<Folder> toFolderList() =>
    docs.mapNotNull((doc) => doc?.toFolder()).toIList();
}

extension FolderFromFirestoreQueryMapper on QueryDocumentSnapshot<Map<String, dynamic>> {
  Folder? toFolder() {
    final data = this.data();
    final id = FolderId(this.id);
    final title = asOrNull<String>(data[Folder.firestoreFieldTitle]);
    final email = asOrNull<Email>(data[Folder.firestoreFieldEmail]);
    final purpose = asOrNull<int>(data[Folder.firestoreFieldPurpose])
        ?.let(FolderPurpose.fromOrdinal);

    if (title == null || email == null || purpose == null) {
      return null;
    }

    return Folder(
      id: id,
      data: FolderData(
        email: email,
        title: title,
        purpose: purpose,
      ),
    );
  }
}

extension FolderFromFirestoreMapper on DocumentSnapshot<Map<String, dynamic>> {
  Folder? toFolder() {
    final id = FolderId(this.id);
    final title = asOrNull<String>(this[Folder.firestoreFieldTitle]);
    final email = asOrNull<Email>(this[Folder.firestoreFieldEmail]);
    final purpose = asOrNull<int>(this[Folder.firestoreFieldPurpose])
      ?.let(FolderPurpose.fromOrdinal);

    if (title == null || email == null || purpose == null) {
      return null;
    }

    return Folder(
      id: id,
      data: FolderData(
        email: email,
        title: title,
        purpose: purpose,
      ),
    );
  }
}

extension FolderToFirestoreMapper on FolderData {
  Map<String, dynamic> toFirestoreData() => {
    Folder.firestoreFieldTitle: title,
    Folder.firestoreFieldEmail: email,
    Folder.firestoreFieldPurpose: purpose.index,
  };
}
