import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/folder_item_input/domain/add_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_item_input/domain/update_folder_item_title_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_item_input/presentation/bloc/folder_item_input_bloc_factory.dart';

extension FolderInputModule on GetIt {
  List<DiEntity> registerFolderItemInputModule() => [
    provideSingleton(() => AddFolderItemUseCase(foldersRepository: this())),

    provideSingleton(() => UpdateFolderItemTitleUseCase(foldersRepository: this())),

    provideSingleton(() => FolderItemInputBlocFactory(
      textChangeUseCase: this(),
      loadFolderUseCase: this(),
      addFolderItemUseCase: this(),
      updateFolderItemTitleUseCase: this(),
      loadFolderItemsEventBus: this(),
    )),
  ];
}
