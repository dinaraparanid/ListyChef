import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class AddFolderUseCase {
  final FoldersRepository _foldersRepository;
  final AuthRepository _authRepository;

  AddFolderUseCase({
    required FoldersRepository foldersRepository,
    required AuthRepository authRepository,
  }) : _foldersRepository = foldersRepository,
    _authRepository = authRepository;

  Future<void> call({
    required String title,
    required FolderPurpose purpose,
    required void Function() onSuccess,
    required void Function() onError,
  }) async {
    try {
      await _foldersRepository.addFolder(
        data: FolderData(
          email: _authRepository.email!,
          title: title,
          purpose: purpose,
        ),
      ).firestoreTimeout();

      onSuccess();
    } catch (e) {
      AppLogger.value.e('Error during folder item add', error: e);
      onError();
    }
  }
}
