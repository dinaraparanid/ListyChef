import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folders_event_bus.dart';
import 'package:listy_chef/feature/main/child/folders/domain/delete_folders_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/domain/load_folders_use_case.dart';
import 'package:listy_chef/feature/main/child/folders/presentation/bloc/folders_bloc.dart';

final class FoldersBlocFactory {
  final TextChangeUseCase _textChangeUseCase;
  final LoadFoldersUseCase _loadFoldersUseCase;
  final DeleteFoldersUseCase _deleteFoldersUseCase;
  final ListDifferenceUseCase _listDifferenceUseCase;
  final LoadFoldersEventBus _loadFoldersEventBus;

  FoldersBlocFactory({
    required TextChangeUseCase textChangeUseCase,
    required LoadFoldersUseCase loadFoldersUseCase,
    required DeleteFoldersUseCase deleteFoldersUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required LoadFoldersEventBus loadFoldersEventBus,
  }) : _textChangeUseCase = textChangeUseCase,
    _loadFoldersUseCase = loadFoldersUseCase,
    _deleteFoldersUseCase = deleteFoldersUseCase,
    _listDifferenceUseCase = listDifferenceUseCase,
    _loadFoldersEventBus = loadFoldersEventBus;

  FoldersBloc call() => FoldersBloc(
    textChangeUseCase: _textChangeUseCase,
    loadFoldersUseCase: _loadFoldersUseCase,
    deleteFoldersUseCase: _deleteFoldersUseCase,
    listDifferenceUseCase: _listDifferenceUseCase,
    loadFoldersEventBus: _loadFoldersEventBus,
  );
}
