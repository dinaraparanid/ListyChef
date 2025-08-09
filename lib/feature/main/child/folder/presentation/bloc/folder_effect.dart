import 'package:listy_chef/core/domain/folders/entity/folder_item.dart';

sealed class FolderEffect {}

final class EffectCheckFolderItem extends FolderEffect {
  final int fromIndex;
  final int toIndex;
  EffectCheckFolderItem({required this.fromIndex, required this.toIndex});
}

final class EffectUncheckFolderItem extends FolderEffect {
  final int fromIndex;
  final int toIndex;
  EffectUncheckFolderItem({required this.fromIndex, required this.toIndex});
}

final class EffectInsertTodoFolderItem extends FolderEffect {
  final int index;
  final FolderItem item;
  EffectInsertTodoFolderItem({required this.index, required this.item});
}

final class EffectInsertAddedFolderItem extends FolderEffect {
  final int index;
  final FolderItem item;
  EffectInsertAddedFolderItem({required this.index, required this.item});
}

final class EffectRemoveTodoFolderItem extends FolderEffect {
  final int index;
  final FolderItem item;
  EffectRemoveTodoFolderItem({required this.index, required this.item});
}

final class EffectRemoveAddedFolderItem extends FolderEffect {
  final int index;
  final FolderItem item;
  EffectRemoveAddedFolderItem({required this.index, required this.item});
}

final class EffectShowUpdateFolderItemMenu extends FolderEffect {
  final FolderItem item;
  EffectShowUpdateFolderItemMenu({required this.item});
}

final class EffectFailedToCheckFolderItem extends FolderEffect {}

final class EffectFailedToUncheckFolderItem extends FolderEffect {}

final class EffectFailedToDeleteFolderItem extends FolderEffect {}

final class EffectFailedToEditFolderItem extends FolderEffect {}
