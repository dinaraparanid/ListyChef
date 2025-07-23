import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_bloc.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_route.dart';

sealed class MainEvent {}

final class EventNavigateToCart extends MainEvent {}

final class EventNavigateToRecipes extends MainEvent {}

final class EventNavigateToProfile extends MainEvent {}

final class EventNavigateToRoute extends MainEvent {
  final MainRoute route;
  EventNavigateToRoute({required this.route});
}

final class EventShowAddProductMenu extends MainEvent {}

extension AddMainEvent on BuildContext {
  void addMainEvent(MainEvent event) =>
    BlocProvider.of<MainBloc>(this).add(event);
}
