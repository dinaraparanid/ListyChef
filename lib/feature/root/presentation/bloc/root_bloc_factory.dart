import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';
import 'package:listy_chef/feature/root/presentation/bloc/root_bloc.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class RootBlocFactory {
  final AppRouter _router;
  final AuthRepository _authRepository;

  RootBlocFactory({
    required AppRouter router,
    required AuthRepository authRepository,
  }) : _router = router, _authRepository = authRepository;

  RootBloc call() => RootBloc(
    router: _router,
    authRepository: _authRepository,
  );
}
