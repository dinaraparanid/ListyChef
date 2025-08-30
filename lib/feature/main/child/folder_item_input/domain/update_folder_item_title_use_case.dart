import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class UpdateFolderItemTitleUseCase {
  final FoldersRepository _foldersRepository;

  UpdateFolderItemTitleUseCase({
    required FoldersRepository foldersRepository,
  }) : _foldersRepository = foldersRepository;

  Future<void> call({
    required FolderItemId id,
    required FolderItemData previousData,
    required String newTitle,
    required void Function() onSuccess,
    required void Function() onError,
  }) => _foldersRepository
    .updateFolderItem(
      id: id,
      newData: previousData.copyWith(
        title: newTitle,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    )
    .firestoreTimeout()
    .then((_) => onSuccess())
    .catchError((e) {
      AppLogger.value.e('Error during folder item title update', error: e);
      onError();
    });
}
