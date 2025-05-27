import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_result.dart';
import 'package:listy_chef/feature/auth/domain/sign_up_use_case.dart';

final class SignUpBlocFactory {
  final SignUpUseCase _signUpUseCase;
  final TextChangeUseCase _textChangeUseCase;

  SignUpBlocFactory({
    required SignUpUseCase signUpUseCase,
    required TextChangeUseCase textChangeUseCase,
  }) : _signUpUseCase = signUpUseCase,
    _textChangeUseCase = textChangeUseCase;

  SignUpBloc create({
    required void Function(SignUpResult) onResult,
  }) => SignUpBloc(
    signUpUseCase: _signUpUseCase,
    textChangeUseCase: _textChangeUseCase,
    onResult: onResult,
  );
}
