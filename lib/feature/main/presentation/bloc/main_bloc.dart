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
    on<EventNavigateToFolders>((event, emit) => emit(
      state.copyWith(route: MainRoute.folders()),
    ));

    on<EventNavigateToFolder>((event, emit) => emit(
      state.copyWith(route: MainRoute.folder(folderId: event.folderId)),
    ));

    on<EventNavigateToTransfer>((event, emit) => emit(
      state.copyWith(route: MainRoute.transfer()),
    ));

    on<EventNavigateToProfile>((event, emit) => emit(
      state.copyWith(route: MainRoute.profile()),
    ));

    on<EventNavigateToRoute>((event, emit) => switch (event.route) {
      MainRouteFolders() => add(EventNavigateToFolders()),

      MainRouteFolder(folderId: final id) =>
        add(EventNavigateToFolder(folderId: id)),

      MainRouteTransfer() => add(EventNavigateToTransfer()),

      MainRouteProfile() => add(EventNavigateToProfile()),
    });

    on<EventShowAddFolderItemMenu>((event, emit) =>
      emitPresentation(EffectShowAddFolderItemMenu(folderId: event.folderId)),
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

  void _navigateToMainRoute(MainRoute route) {
    void clearStack() {
      while (_router.value.canPop()) {
        _router.value.pop();
      }
    }

    switch (route) {
      case MainRouteFolders():
        clearStack();
        _router.value.goNamed(AppRoute.folders.name);

      case MainRouteFolder():
        _router.value.pushNamed(
          AppRoute.folder.name,
          pathParameters: {
            AppRoute.pathFolderId: route.folderId.value,
          },
        );

      case MainRouteTransfer():
        clearStack();
        _router.value.goNamed(AppRoute.transfer.name);

      case MainRouteProfile():
        clearStack();
        _router.value.goNamed(AppRoute.profile.name);
    }
  }
}
