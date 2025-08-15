import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/feature/main/child/folder/di/folder_module.dart';
import 'package:listy_chef/feature/main/child/folder_input/di/folder_input_module.dart';
import 'package:listy_chef/feature/main/child/folders/di/folders_module.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_bloc_factory.dart';

extension MainModule on GetIt {
  List<DiEntity> registerMainModule() => [
    ...registerFoldersModule(),
    ...registerFolderModule(),
    ...registerFolderInputModule(),
    provideSingleton(() => MainBlocFactory(router: this())),
  ];
}
