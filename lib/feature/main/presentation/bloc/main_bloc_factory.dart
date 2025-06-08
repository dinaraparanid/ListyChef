import 'package:listy_chef/feature/main/presentation/bloc/main_bloc.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class MainBlocFactory {
  final AppRouter _router;

  MainBlocFactory({
    required AppRouter router,
  }) : _router = router;

  MainBloc create() => MainBloc(router: _router);
}
