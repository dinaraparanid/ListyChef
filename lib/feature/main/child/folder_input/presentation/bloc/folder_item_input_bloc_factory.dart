import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folder_items_event_bus.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/add_folder_item_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/update_folder_item_title_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_mode.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_item_input_bloc.dart';

final class FolderItemInputBlocFactory {
  final TextChangeUseCase _textChangeUseCase;
  final AddFolderItemUseCase _addFolderItemUseCase;
  final UpdateFolderItemTitleUseCase _updateFolderItemTitleUseCase;
  final LoadFolderItemsEventBus _loadFolderItemsEventBus;

  FolderItemInputBlocFactory({
    required TextChangeUseCase textChangeUseCase,
    required AddFolderItemUseCase addFolderItemUseCase,
    required UpdateFolderItemTitleUseCase updateFolderItemTitleUseCase,
    required LoadFolderItemsEventBus loadFolderItemsEventBus,
  }) : _textChangeUseCase = textChangeUseCase,
    _addFolderItemUseCase = addFolderItemUseCase,
    _updateFolderItemTitleUseCase = updateFolderItemTitleUseCase,
    _loadFolderItemsEventBus = loadFolderItemsEventBus;

  FolderItemInputBloc call({
    required FolderInputMode mode,
    required FolderId folderId,
    FolderItem? initialItem,
  }) => FolderItemInputBloc(
    mode: mode,
    folderId: folderId,
    initialItem: initialItem,
    textChangeUseCase: _textChangeUseCase,
    addFolderItemUseCase: _addFolderItemUseCase,
    updateFolderItemTitleUseCase: _updateFolderItemTitleUseCase,
    loadFolderItemsEventBus: _loadFolderItemsEventBus,
  );
}
