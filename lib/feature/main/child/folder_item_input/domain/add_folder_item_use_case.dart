import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class AddFolderItemUseCase {
  final FoldersRepository _foldersRepository;

  AddFolderItemUseCase({
    required FoldersRepository foldersRepository,
  }) : _foldersRepository = foldersRepository;

  Future<void> call({
    required String title,
    required FolderId folderId,
    required FolderPurpose purpose,
    required void Function() onSuccess,
    required void Function() onError,
  }) => _foldersRepository
    .addFolderItem(
      data: switch (purpose) {
        FolderPurpose.check => FolderItemData.check(
          isAdded: false,
          title: title,
          folderId: folderId,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),

        FolderPurpose.list => FolderItemData.list(
          title: title,
          folderId: folderId,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),
      },
    )
    .firestoreTimeout()
    .then((_) => onSuccess())
    .catchError((e) {
      AppLogger.value.e('Error during folder item add', error: e);
      onError();
    });
}
