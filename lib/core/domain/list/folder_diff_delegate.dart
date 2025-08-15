import 'package:diffutil_dart/diffutil.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/folders/entity/folder.dart';

final class FolderDiffDelegate implements IndexableItemDiffDelegate<Folder> {
  final IList<Folder> oldList;
  final IList<Folder> newList;

  FolderDiffDelegate({
    required this.oldList,
    required this.newList,
  });

  @override
  bool areItemsTheSame(int oldItemPosition, int newItemPosition) =>
    oldList[oldItemPosition].id == newList[newItemPosition].id;

  @override
  bool areContentsTheSame(int oldItemPosition, int newItemPosition) =>
    oldList[oldItemPosition] == newList[newItemPosition];

  @override
  Object? getChangePayload(int oldItemPosition, int newItemPosition) => null;

  @override
  Folder getNewItemAtIndex(int index) => newList[index];

  @override
  int getNewListSize() => newList.length;

  @override
  Folder getOldItemAtIndex(int index) => oldList[index];

  @override
  int getOldListSize() => oldList.length;
}
