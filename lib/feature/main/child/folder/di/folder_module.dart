import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/folder/domain/check_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/delete_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_check_folder_items_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_items_event_bus.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_list_folder_items_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_bloc_factory.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_bloc_factory.dart';

extension FolderModule on GetIt {
  List<DiEntity> registerFolderModule() => [
    provideSingleton(() => LoadFolderUseCase(foldersRepository: this())),
    provideSingleton(() => LoadCheckFolderItemsUseCase(foldersRepository: this())),
    provideSingleton(() => LoadListFolderItemsUseCase(foldersRepository: this())),
    provideSingleton(() => CheckFolderItemUseCase(foldersRepository: this())),
    provideSingleton(() => DeleteFolderItemUseCase(foldersRepository: this())),

    provideSingleton(() => LoadFolderItemsEventBus()),

    provideSingleton(() => CheckFolderBlocFactory(
      loadFolderUseCase: this(),
      textChangeUseCase: this(),
      loadCheckFolderItemsUseCase: this(),
      checkFolderItemUseCase: this(),
      deleteFolderItemUseCase: this(),
      listDifferenceUseCase: this(),
      loadFolderItemsEventBus: this(),
    )),

    provideSingleton(() => ListFolderBlocFactory(
      loadFolderUseCase: this(),
      textChangeUseCase: this(),
      loadListFolderItemsUseCase: this(),
      deleteFolderItemUseCase: this(),
      listDifferenceUseCase: this(),
      loadFolderItemsEventBus: this(),
    )),
  ];
}
