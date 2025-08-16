import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';
import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/check_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/delete_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_check_folder_items_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_items_event_bus.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/check/check_folder_bloc.dart';

final class CheckFolderBlocFactory {
  final LoadFolderUseCase _loadFolderUseCase;
  final TextChangeUseCase _textChangeUseCase;
  final LoadCheckFolderItemsUseCase _loadCheckFolderItemsUseCase;
  final CheckFolderItemUseCase _checkFolderItemUseCase;
  final DeleteFolderItemUseCase _deleteFolderItemUseCase;
  final ListDifferenceUseCase _listDifferenceUseCase;
  final LoadFolderItemsEventBus _loadFolderItemsEventBus;

  CheckFolderBlocFactory({
    required LoadFolderUseCase loadFolderUseCase,
    required TextChangeUseCase textChangeUseCase,
    required LoadCheckFolderItemsUseCase loadCheckFolderItemsUseCase,
    required CheckFolderItemUseCase checkFolderItemUseCase,
    required DeleteFolderItemUseCase deleteFolderItemUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required LoadFolderItemsEventBus loadFolderItemsEventBus,
  }) : _loadFolderUseCase = loadFolderUseCase,
    _textChangeUseCase = textChangeUseCase,
    _loadCheckFolderItemsUseCase = loadCheckFolderItemsUseCase,
    _checkFolderItemUseCase = checkFolderItemUseCase,
    _deleteFolderItemUseCase = deleteFolderItemUseCase,
    _listDifferenceUseCase = listDifferenceUseCase,
    _loadFolderItemsEventBus = loadFolderItemsEventBus;

  CheckFolderBloc call({required FolderId folderId}) => CheckFolderBloc(
    folderId: folderId,
    loadFolderUseCase: _loadFolderUseCase,
    textChangeUseCase: _textChangeUseCase,
    loadCheckFolderItemsUseCase: _loadCheckFolderItemsUseCase,
    checkFolderItemUseCase: _checkFolderItemUseCase,
    deleteFolderItemUseCase: _deleteFolderItemUseCase,
    listDifferenceUseCase: _listDifferenceUseCase,
    loadFolderItemsEventBus: _loadFolderItemsEventBus,
  );
}
