import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';

sealed class MainEffect {}

final class EffectShowAddFolderItemMenu extends MainEffect {
  final FolderId folderId;
  EffectShowAddFolderItemMenu({required this.folderId});
}
