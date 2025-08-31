import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class DeleteFoldersUseCase {
  final FoldersRepository _foldersRepository;

  DeleteFoldersUseCase({
    required FoldersRepository foldersRepository,
  }) : _foldersRepository = foldersRepository;

  Future<void> call({
    required ISet<FolderId> ids,
    required void Function() onSuccess,
    required void Function() onFailure,
  }) => Future
    .wait(
      ids.map((id) => _foldersRepository
        .removeFolder(id: id)
        .firestoreTimeout(),
      ),
    )
    .then((_) => onSuccess())
    .catchError((e) {
      AppLogger.value.e('Error during folder delete', error: e);
      onFailure();
    });
}
