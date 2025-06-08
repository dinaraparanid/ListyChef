import 'package:listy_chef/feature/main/presentation/bloc/main_route.dart';

sealed class MainEvent {}

final class EventNavigateToCart extends MainEvent {}

final class EventNavigateToRecipes extends MainEvent {}

final class EventNavigateToProfile extends MainEvent {}

final class EventNavigateToRoute extends MainEvent {
  final MainRoute route;
  EventNavigateToRoute({required this.route});
}
