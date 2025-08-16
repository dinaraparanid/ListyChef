import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';
import 'package:listy_chef/core/domain/list/list_difference_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/delete_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_items_event_bus.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_list_folder_items_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/presentation/bloc/list/list_folder_bloc.dart';

final class ListFolderBlocFactory {
  final LoadFolderUseCase _loadFolderUseCase;
  final TextChangeUseCase _textChangeUseCase;
  final LoadListFolderItemsUseCase _loadListFolderItemsUseCase;
  final DeleteFolderItemUseCase _deleteFolderItemUseCase;
  final ListDifferenceUseCase _listDifferenceUseCase;
  final LoadFolderItemsEventBus _loadFolderItemsEventBus;

  ListFolderBlocFactory({
    required LoadFolderUseCase loadFolderUseCase,
    required TextChangeUseCase textChangeUseCase,
    required LoadListFolderItemsUseCase loadListFolderItemsUseCase,
    required DeleteFolderItemUseCase deleteFolderItemUseCase,
    required ListDifferenceUseCase listDifferenceUseCase,
    required LoadFolderItemsEventBus loadFolderItemsEventBus,
  }) : _loadFolderUseCase = loadFolderUseCase,
    _textChangeUseCase = textChangeUseCase,
    _loadListFolderItemsUseCase = loadListFolderItemsUseCase,
    _deleteFolderItemUseCase = deleteFolderItemUseCase,
    _listDifferenceUseCase = listDifferenceUseCase,
    _loadFolderItemsEventBus = loadFolderItemsEventBus;

  ListFolderBloc call({required FolderId folderId}) => ListFolderBloc(
    folderId: folderId,
    loadFolderUseCase: _loadFolderUseCase,
    textChangeUseCase: _textChangeUseCase,
    loadListFolderItemsUseCase: _loadListFolderItemsUseCase,
    deleteFolderItemUseCase: _deleteFolderItemUseCase,
    listDifferenceUseCase: _listDifferenceUseCase,
    loadFolderItemsEventBus: _loadFolderItemsEventBus,
  );
}
