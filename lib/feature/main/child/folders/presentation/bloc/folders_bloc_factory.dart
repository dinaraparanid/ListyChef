import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/domain/load_folders_event_bus.dart';
import 'package:listy_chef/feature/main/child/folders/domain/load_folders_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_bloc.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class FoldersBlocFactory {
  final AppRouter _router;
  final TextChangeUseCase _textChangeUseCase;
  final LoadFoldersUseCase _loadFoldersUseCase;
  final ListDifferenceUseCase _listDifferenceUseCase;
  final LoadFoldersEventBus _loadFoldersEventBus;

  FoldersBlocFactory({
    required AppRouter router,
    required TextChangeUseCase textChangeUseCase,
    required LoadFoldersUseCase loadFoldersUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required LoadFoldersEventBus loadFoldersEventBus,
  }) : _router = router,
    _textChangeUseCase = textChangeUseCase,
    _loadFoldersUseCase = loadFoldersUseCase,
    _listDifferenceUseCase = listDifferenceUseCase,
    _loadFoldersEventBus = loadFoldersEventBus;

  FoldersBloc call() => FoldersBloc(
    router: _router,
    textChangeUseCase: _textChangeUseCase,
    loadFoldersUseCase: _loadFoldersUseCase,
    listDifferenceUseCase: _listDifferenceUseCase,
    loadFoldersEventBus: _loadFoldersEventBus,
  );
}
