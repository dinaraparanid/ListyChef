import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';
import 'package:listy_chef/feature/root/presentation/bloc/root_event.dart';
import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class RootBloc extends Bloc<RootEvent, void> {
  StreamSubscription<bool>? _authorizedListener;

  RootBloc({
    required AppRouter router,
    required AuthRepository authRepository,
  }) : super(null) {
    on<EventNavigateToAuth>((event, emit) =>
      router.value.replaceNamed(AppRoute.auth.name),
    );

    on<EventNavigateToMain>((event, emit) =>
      router.value.replaceNamed(AppRoute.main.name),
    );

    _authorizedListener = authRepository.signedInChanges.listen((isAuthorized) =>
      add(isAuthorized ? EventNavigateToMain() : EventNavigateToAuth()),
    );
  }

  @override
  Future<void> close() async {
    await _authorizedListener?.cancel();
    _authorizedListener = null;
    return super.close();
  }
}
