import 'package:listy_chef/core/domain/folders/entity/folder_item.dart';

sealed class CheckFolderEffect {}

final class EffectCheckFolderItem extends CheckFolderEffect {
  final int fromIndex;
  final int toIndex;
  EffectCheckFolderItem({required this.fromIndex, required this.toIndex});
}

final class EffectUncheckFolderItem extends CheckFolderEffect {
  final int fromIndex;
  final int toIndex;
  EffectUncheckFolderItem({required this.fromIndex, required this.toIndex});
}

final class EffectInsertTodoFolderItem extends CheckFolderEffect {
  final int index;
  final FolderItem item;
  EffectInsertTodoFolderItem({required this.index, required this.item});
}

final class EffectInsertAddedFolderItem extends CheckFolderEffect {
  final int index;
  final FolderItem item;
  EffectInsertAddedFolderItem({required this.index, required this.item});
}

final class EffectRemoveTodoFolderItem extends CheckFolderEffect {
  final int index;
  final FolderItem item;
  EffectRemoveTodoFolderItem({required this.index, required this.item});
}

final class EffectRemoveAddedFolderItem extends CheckFolderEffect {
  final int index;
  final FolderItem item;
  EffectRemoveAddedFolderItem({required this.index, required this.item});
}

final class EffectShowUpdateFolderItemMenu extends CheckFolderEffect {
  final FolderItem item;
  EffectShowUpdateFolderItemMenu({required this.item});
}

final class EffectFailedToCheckFolderItem extends CheckFolderEffect {}

final class EffectFailedToUncheckFolderItem extends CheckFolderEffect {}

final class EffectFailedToDeleteFolderItem extends CheckFolderEffect {}

final class EffectFailedToEditFolderItem extends CheckFolderEffect {}
