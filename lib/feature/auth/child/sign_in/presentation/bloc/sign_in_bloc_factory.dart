import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_result.dart';

final class SignInBlocFactory {
  final TextChangeUseCase _textChangeUseCase;

  SignInBlocFactory({
    required TextChangeUseCase textChangeUseCase,
  }) : _textChangeUseCase = textChangeUseCase;

  SignInBloc create({
    required void Function(SignInResult) onResult,
  }) => SignInBloc(
    textChangeUseCase: _textChangeUseCase,
    onResult: onResult,
  );
}
