import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/folders/entity/folder_id.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_bloc.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_route.dart';

sealed class MainEvent {}

final class EventNavigateToFolders extends MainEvent {}

final class EventNavigateToFolder extends MainEvent {
  final FolderId folderId;
  EventNavigateToFolder({required this.folderId});
}

final class EventNavigateToTransfer extends MainEvent {}

final class EventNavigateToProfile extends MainEvent {}

final class EventNavigateToRoute extends MainEvent {
  final MainRoute route;
  EventNavigateToRoute({required this.route});
}

final class EventShowAddFolderItemMenu extends MainEvent {
  final FolderId folderId;
  EventShowAddFolderItemMenu({required this.folderId});
}

extension AddMainEvent on BuildContext {
  void addMainEvent(MainEvent event) =>
    BlocProvider.of<MainBloc>(this).add(event);
}
