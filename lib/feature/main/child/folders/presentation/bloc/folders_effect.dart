import 'package:listy_chef/core/domain/folders/entity/folder.dart';

sealed class FoldersEffect {}

final class EffectInsertFolder extends FoldersEffect {
  final int index;
  final Folder folder;
  EffectInsertFolder({required this.index, required this.folder});
}

final class EffectRemoveFolder extends FoldersEffect {
  final int index;
  final Folder folder;
  EffectRemoveFolder({required this.index, required this.folder});
}
