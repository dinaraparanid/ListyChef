import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/mod.dart';
import 'package:listy_chef/feature/main/child/folder_input/presentation/bloc/folder_input_bloc.dart';

sealed class FolderInputEvent {}

final class EventUpdatePurpose extends FolderInputEvent {
  final FolderPurpose purpose;
  EventUpdatePurpose({required this.purpose});
}

final class EventUpdateTitle extends FolderInputEvent {
  final String title;
  EventUpdateTitle({required this.title});
}

final class EventConfirm extends FolderInputEvent {}

final class EventTriggerRefresh extends FolderInputEvent {}

extension AddFolderInputEvent on BuildContext {
  void addFolderInputEvent(FolderInputEvent event) =>
    BlocProvider.of<FolderInputBloc>(this).add(event);
}
