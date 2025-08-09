import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';

final class LoadCheckFolderItemsUseCase {
  final FoldersRepository _foldersRepository;

  LoadCheckFolderItemsUseCase({required FoldersRepository foldersRepository}) :
    _foldersRepository = foldersRepository;

  Future<(UiState<IList<FolderItem>>, UiState<IList<FolderItem>>)> call({
    required FolderId folderId,
  }) async {
    try {
      final items = await _foldersRepository.folderItems(folderId: folderId);

      final (todo, added) = items.partition((item) =>
        item.data.map(check: (d) => d.isAdded, list: (_) => false)
      );

      return (todo.toIList().toUiState(), added.toIList().toUiState());
    } catch (e) {
      return (
        UiState<IList<FolderItem>>.error(),
        UiState<IList<FolderItem>>.error(),
      );
    }
  }
}
