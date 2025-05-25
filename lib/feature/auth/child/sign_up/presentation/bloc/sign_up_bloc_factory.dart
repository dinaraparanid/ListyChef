import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_result.dart';

final class SignUpBlocFactory {
  final TextChangeUseCase _textChangeUseCase;

  SignUpBlocFactory({
    required TextChangeUseCase textChangeUseCase,
  }) : _textChangeUseCase = textChangeUseCase;

  SignUpBloc create({
    required void Function(SignUpResult) onResult,
  }) => SignUpBloc(
    textChangeUseCase: _textChangeUseCase,
    onResult: onResult,
  );
}
