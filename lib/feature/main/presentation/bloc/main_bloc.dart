import 'dart:async';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_effect.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_event.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_route.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_state.dart';
import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class MainBloc extends Bloc<MainEvent, MainState>
  with BlocPresentationMixin<MainState, MainEffect> {

  final AppRouter _router;

  StreamSubscription<MainRoute>? _routeListener;

  MainBloc({
    required AppRouter router,
  }) : _router = router, super(MainState()) {
    on<EventNavigateToCart>((event, emit) => emit(
      state.copyWith(route: MainRoute.cart()),
    ));

    on<EventNavigateToRecipes>((event, emit) => emit(
      state.copyWith(route: MainRoute.recipes()),
    ));

    on<EventNavigateToProfile>((event, emit) => emit(
      state.copyWith(route: MainRoute.profile()),
    ));

    on<EventNavigateToRoute>((event, emit) => switch (event.route) {
      MainRouteCart() => add(EventNavigateToCart()),
      MainRouteRecipes() => add(EventNavigateToRecipes()),
      MainRouteProfile() => add(EventNavigateToProfile()),
    });

    on<EventShowAddProductMenu>((event, emit) =>
      emitPresentation(EffectShowAddProductMenu()),
    );

    _listenRouteChanges();
  }

  @override
  Future<void> close() async {
    await _routeListener?.cancel();
    _routeListener = null;
    return super.close();
  }

  void _listenRouteChanges() {
    _routeListener = stream
      .map((s) => s.route)
      .distinct()
      .listen(_navigateToMainRoute);
  }

  void _navigateToMainRoute(MainRoute route) => switch (route) {
    MainRouteCart() => _router.value.goNamed(AppRoute.cart.name),
    MainRouteRecipes() => _router.value.goNamed(AppRoute.recipes.name),
    MainRouteProfile() => _router.value.goNamed(AppRoute.profile.name),
  };
}
