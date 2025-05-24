import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class SignInBlocFactory {
  final AppRouter _router;
  final TextChangeUseCase _textChangeUseCase;

  SignInBlocFactory({
    required AppRouter router,
    required TextChangeUseCase textChangeUseCase,
  }) : _router = router, _textChangeUseCase = textChangeUseCase;

  SignInBloc create() => SignInBloc(
    router: _router,
    textChangeUseCase: _textChangeUseCase,
  );
}
