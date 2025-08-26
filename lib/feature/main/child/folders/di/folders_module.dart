import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/folders/domain/load_folders_event_bus.dart';
import 'package:listy_chef/feature/main/child/folders/domain/load_folders_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_bloc_factory.dart';

extension FoldersModule on GetIt {
  List<DiEntity> registerFoldersModule() => [
    provideSingleton(() => LoadFoldersUseCase(
      foldersRepository: this(),
      authRepository: this(),
    )),

    provideSingleton(() => LoadFoldersEventBus()),

    provideSingleton(() => FoldersBlocFactory(
      router: this(),
      textChangeUseCase: this(),
      loadFoldersUseCase: this(),
      listDifferenceUseCase: this(),
      loadFoldersEventBus: this(),
    )),
  ];
}
