import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_purpose.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';

final class LoadFolderPurposeUseCase {
  final FoldersRepository _foldersRepository;

  LoadFolderPurposeUseCase({
    required FoldersRepository foldersRepository,
  }) : _foldersRepository = foldersRepository;

  Future<UiState<FolderPurpose>> call({required FolderId id}) =>
    _foldersRepository.folderPurpose(id: id).then((it) =>
      it?.toUiState() ?? UiState.error(),
    );
}
