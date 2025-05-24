import 'package:listy_chef/feature/root/presentation/bloc/root_bloc.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class RootBlocFactory {
  final AppRouter _router;

  RootBlocFactory({
    required AppRouter router,
  }) : _router = router;

  RootBloc create() => RootBloc(
    router: _router,
  );
}
