import 'package:listy_chef/core/domain/folders/entity/folder_item.dart';

sealed class ListFolderEffect {}

final class EffectInsertFolderItem extends ListFolderEffect {
  final int index;
  final FolderItem item;
  EffectInsertFolderItem({required this.index, required this.item});
}

final class EffectRemoveFolderItem extends ListFolderEffect {
  final int index;
  final FolderItem item;
  EffectRemoveFolderItem({required this.index, required this.item});
}

final class EffectShowUpdateFolderItemMenu extends ListFolderEffect {
  final FolderItem item;
  EffectShowUpdateFolderItemMenu({required this.item});
}

final class EffectFailedToDeleteFolderItem extends ListFolderEffect {}

final class EffectFailedToEditFolderItem extends ListFolderEffect {}
