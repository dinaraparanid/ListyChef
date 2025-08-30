import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/feature/main/child/folder_item_input/presentation/bloc/folder_item_input_bloc.dart';

sealed class FolderItemInputEvent {}

final class EventUpdatePurpose extends FolderItemInputEvent {
  final FolderPurpose purpose;
  EventUpdatePurpose({required this.purpose});
}

final class EventUpdateTitle extends FolderItemInputEvent {
  final String title;
  EventUpdateTitle({required this.title});
}

final class EventConfirm extends FolderItemInputEvent {}

final class EventTriggerRefresh extends FolderItemInputEvent {}

extension AddFolderItemInputEvent on BuildContext {
  void addFolderItemInputEvent(FolderItemInputEvent event) =>
    BlocProvider.of<FolderItemInputBloc>(this).add(event);
}
