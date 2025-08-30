import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/core/domain/folders/use_case/load_folder_use_case.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/folder/domain/load_folders_event_bus.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/add_folder_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/domain/update_folder_title_use_case.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_bloc.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_mode.dart';

final class FolderInputBlocFactory {
  final TextChangeUseCase _textChangeUseCase;
  final LoadFolderUseCase _loadFolderUseCase;
  final AddFolderUseCase _addFolderUseCase;
  final UpdateFolderTitleUseCase _updateFolderTitleUseCase;
  final LoadFoldersEventBus _loadFoldersEventBus;

  FolderInputBlocFactory({
    required TextChangeUseCase textChangeUseCase,
    required LoadFolderUseCase loadFolderUseCase,
    required AddFolderUseCase addFolderUseCase,
    required UpdateFolderTitleUseCase updateFolderTitleUseCase,
    required LoadFoldersEventBus loadFoldersEventBus,
  }) : _textChangeUseCase = textChangeUseCase,
    _loadFolderUseCase = loadFolderUseCase,
    _addFolderUseCase = addFolderUseCase,
    _updateFolderTitleUseCase = updateFolderTitleUseCase,
    _loadFoldersEventBus = loadFoldersEventBus;

  FolderInputBloc call({
    required FolderInputMode mode,
    Folder? initialItem,
  }) => FolderInputBloc(
    mode: mode,
    initialItem: initialItem,
    textChangeUseCase: _textChangeUseCase,
    loadFolderUseCase: _loadFolderUseCase,
    addFolderUseCase: _addFolderUseCase,
    updateFolderTitleUseCase: _updateFolderTitleUseCase,
    loadFoldersEventBus: _loadFoldersEventBus,
  );
}
