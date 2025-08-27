import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';

final class LoadFolderUseCase {
  final FoldersRepository _foldersRepository;

  LoadFolderUseCase({required FoldersRepository foldersRepository}) :
    _foldersRepository = foldersRepository;

  Future<UiState<Folder>> call({required FolderId id}) =>
    _foldersRepository.folder(id: id).then((it) =>
      it != null ? it.toUiState() : UiState.error()
    );
}
