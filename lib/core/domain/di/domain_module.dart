import 'package:get_it/get_it.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/core/domain/folders/use_case/load_folder_use_case.dart';
import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';

extension DomainModule on GetIt {
  List<DiEntity> registerDomainModule() => [
    provideSingleton(() => TextChangeUseCase()),
    provideSingleton(() => ListDifferenceUseCase()),
    provideSingleton(() => LoadFolderUseCase(foldersRepository: this())),
  ];
}
