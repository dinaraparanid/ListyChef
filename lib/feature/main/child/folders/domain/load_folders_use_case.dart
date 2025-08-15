import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/repository/folders_repository.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';

final class LoadFoldersUseCase {
  final FoldersRepository _foldersRepository;
  final AuthRepository _authRepository;

  LoadFoldersUseCase({
    required FoldersRepository foldersRepository,
    required AuthRepository authRepository,
  }) : _foldersRepository = foldersRepository,
    _authRepository = authRepository;

  Future<UiState<IList<Folder>>> call() async {
    try {
      final email = _authRepository.email;

      if (email == null) {
        return UiState<IList<Folder>>.error();
      }

      final folders = await _foldersRepository.folders(email: email);
      return folders.toIList().toUiState();
    } catch (e) {
      return UiState<IList<Folder>>.error();
    }
  }
}
