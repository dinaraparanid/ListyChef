import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';

final class LoadListFolderItemsUseCase {
  final FoldersRepository _foldersRepository;

  LoadListFolderItemsUseCase({required FoldersRepository foldersRepository}) :
    _foldersRepository = foldersRepository;

  Future<UiState<IList<FolderItem>>> call({
    required FolderId folderId,
  }) async {
    try {
      final items = await _foldersRepository.folderItems(folderId: folderId);
      return items.toIList().toUiState();
    } catch (e) {
      return UiState<IList<FolderItem>>.error();
    }
  }
}
