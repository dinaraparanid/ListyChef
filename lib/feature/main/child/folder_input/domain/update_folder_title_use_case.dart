import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class UpdateFolderTitleUseCase {
  final FoldersRepository _foldersRepository;

  UpdateFolderTitleUseCase({
    required FoldersRepository foldersRepository,
  }) : _foldersRepository = foldersRepository;

  Future<void> call({
    required FolderId id,
    required FolderData previousData,
    required String newTitle,
    required void Function() onSuccess,
    required void Function() onError,
  }) => _foldersRepository
    .updateFolder(
      id: id,
      newData: previousData.copyWith(title: newTitle),
    )
    .firestoreTimeout()
    .then((_) => onSuccess())
    .catchError((e) {
      AppLogger.value.e('Error during folder item title update', error: e);
      onError();
    });
}
