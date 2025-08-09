import 'package:listy_chef/core/domain/folders/entity/folder_item_id.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class CheckFolderItemUseCase {
  final FoldersRepository _foldersRepository;

  CheckFolderItemUseCase({
    required FoldersRepository foldersRepository,
  }) : _foldersRepository = foldersRepository;

  Future<void> call({
    required FolderItemId id,
    required void Function() onError,
  }) => _foldersRepository
    .checkFolderItem(id: id)
    .firestoreTimeout()
    .catchError((e) {
      AppLogger.value.e('Error during folder item check', error: e);
      onError();
    });
}
