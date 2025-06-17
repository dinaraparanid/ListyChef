import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_result.dart';
import 'package:listy_chef/feature/auth/domain/sign_in_use_case.dart';

final class SignInBlocFactory {
  final SignInUseCase _signInUseCase;
  final TextChangeUseCase _textChangeUseCase;

  SignInBlocFactory({
    required SignInUseCase signInUseCase,
    required TextChangeUseCase textChangeUseCase,
  }) : _signInUseCase = signInUseCase,
    _textChangeUseCase = textChangeUseCase;

  SignInBloc call({
    String? email,
    required void Function(SignInResult) onResult,
  }) => SignInBloc(
    signInUseCase: _signInUseCase,
    textChangeUseCase: _textChangeUseCase,
    onResult: onResult,
  );
}
