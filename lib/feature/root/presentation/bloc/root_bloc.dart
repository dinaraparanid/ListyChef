import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/root/presentation/bloc/root_event.dart';
import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class RootBloc extends Bloc<RootEvent, void> {
  RootBloc({
    required AppRouter router,
  }) : super(null) {
    on<NavigateToAuth>((event, emit) =>
      router.value.replaceNamed(AppRoute.auth.name),
    );

    on<NavigateToMain>((event, emit) =>
      router.value.replaceNamed(AppRoute.main.name),
    );
  }
}
