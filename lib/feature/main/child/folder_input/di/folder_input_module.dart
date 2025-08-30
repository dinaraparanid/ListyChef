import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/add_folder_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/update_folder_title_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_bloc_factory.dart';

extension FolderInputModule on GetIt {
  List<DiEntity> registerFolderInputModule() => [
    provideSingleton(() => AddFolderUseCase(
      foldersRepository: this(),
      authRepository: this(),
    )),

    provideSingleton(() => UpdateFolderTitleUseCase(foldersRepository: this())),

    provideSingleton(() => FolderInputBlocFactory(
      textChangeUseCase: this(),
      loadFolderUseCase: this(),
      addFolderUseCase: this(),
      updateFolderTitleUseCase: this(),
      loadFoldersEventBus: this(),
    )),
  ];
}
