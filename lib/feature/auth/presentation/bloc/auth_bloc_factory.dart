import 'package:listy_chef/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class AuthBlocFactory {
  final AppRouter _router;

  AuthBlocFactory({required AppRouter router}) : _router = router;

  AuthBloc create() => AuthBloc(router: _router);
}
