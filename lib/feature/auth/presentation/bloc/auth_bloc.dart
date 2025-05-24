import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_event.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_route.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_state.dart';
import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppRouter _router;

  StreamSubscription<AuthRoute>? _routeListener;

  AuthBloc({
    required AppRouter router,
  }) : _router = router, super(AuthState()) {
    on<NavigateToSignIn>((event, emit) =>
      emit(state.copyWith(route: AuthRoute.signIn)),
    );

    on<NavigateToSignUp>((event, emit) =>
      emit(state.copyWith(route: AuthRoute.signUp)),
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
      .listen(_navigateToAuthRoute);
  }

  void _navigateToAuthRoute(AuthRoute route) => switch (route) {
    AuthRoute.signIn => _router.value.goNamed(AppRoute.signIn.name),
    AuthRoute.signUp => _router.value.goNamed(AppRoute.signUp.name),
  };
}
