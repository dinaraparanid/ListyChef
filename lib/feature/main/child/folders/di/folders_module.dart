import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/folders/domain/delete_folders_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/domain/load_folders_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_bloc_factory.dart';

extension FoldersModule on GetIt {
  List<DiEntity> registerFoldersModule() => [
    provideSingleton(() => LoadFoldersUseCase(
      foldersRepository: this(),
      authRepository: this(),
    )),

    provideSingleton(() => DeleteFoldersUseCase(
      foldersRepository: this(),
    )),

    provideSingleton(() => FoldersBlocFactory(
      textChangeUseCase: this(),
      loadFoldersUseCase: this(),
      deleteFoldersUseCase: this(),
      listDifferenceUseCase: this(),
      loadFoldersEventBus: this(),
    )),
  ];
}
