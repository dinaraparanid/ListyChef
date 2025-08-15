import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_bloc_factory.dart';

extension FoldersModule on GetIt {
  List<DiEntity> registerFoldersModule() => [
    provideSingleton(() => FoldersBlocFactory(
      textChangeUseCase: this(),
      listDifferenceUseCase: this(),
    )),
  ];
}
