import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_result.dart' as sign_in_result;
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_result.dart' as sign_up_result;
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
    on<EventNavigateToSignIn>((event, emit) =>
      emit(state.copyWith(route: AuthRoute.signIn(email: event.email))),
    );

    on<EventNavigateToSignUp>((event, emit) =>
      emit(state.copyWith(route: AuthRoute.signUp(email: event.email))),
    );

    on<EventNavigateToMain>((event, emit) =>
      router.value.goNamed(AppRoute.main.name),
    );

    on<EventHandleSignInResult>((event, emit) => switch (event.result) {
      sign_in_result.ResultGoToSignUp(email: final e) =>
        add(EventNavigateToSignUp(email: e)),

      sign_in_result.ResultGoToMain() => add(EventNavigateToMain()),
    });

    on<EventHandleSignUpResult>((event, emit) => switch (event.result) {
      sign_up_result.ResultGoToSignIn(email: final e) =>
        add(EventNavigateToSignIn(email: e)),

      sign_up_result.ResultGoToMain() => add(EventNavigateToMain()),
    });

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
    AuthRouteSignIn() => _router.value.goNamed(
      AppRoute.signIn.name,
      queryParameters: { AppRoute.queryEmail: route.email },
    ),

    AuthRouteSignUp() => _router.value.goNamed(
      AppRoute.signUp.name,
      queryParameters: { AppRoute.queryEmail: route.email },
    ),
  };
}
