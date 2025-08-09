import 'package:diffutil_dart/diffutil.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_item.dart';

final class FolderItemDiffDelegate implements IndexableItemDiffDelegate<FolderItem> {
  final IList<FolderItem> oldList;
  final IList<FolderItem> newList;

  FolderItemDiffDelegate({
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
  FolderItem getNewItemAtIndex(int index) => newList[index];

  @override
  int getNewListSize() => newList.length;

  @override
  FolderItem getOldItemAtIndex(int index) => oldList[index];

  @override
  int getOldListSize() => oldList.length;
}
