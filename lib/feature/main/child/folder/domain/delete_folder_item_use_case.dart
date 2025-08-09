import 'package:listy_chef/core/domain/folders/entity/folder_item_id.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class DeleteFolderItemUseCase {
  final FoldersRepository _foldersRepository;

  DeleteFolderItemUseCase({
    required FoldersRepository foldersRepository,
  }) : _foldersRepository = foldersRepository;

  Future<void> call({
    required FolderItemId id,
    required void Function() onSuccess,
    required void Function() onFailure,
  }) => _foldersRepository
    .removeFolderItem(id: id)
    .firestoreTimeout()
    .then((_) => onSuccess())
    .catchError((e) {
      AppLogger.value.e('Error during product delete', error: e);
      onFailure();
    });
}
