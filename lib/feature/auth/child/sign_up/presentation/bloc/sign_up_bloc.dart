import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_result.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:listy_chef/feature/auth/domain/sign_up_use_case.dart';

final class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required SignUpUseCase signUpUseCase,
    required TextChangeUseCase textChangeUseCase,
    required void Function(SignUpResult) onResult,
  }) : super(SignUpState()) {
    on<EventBack>((event, emit) => onResult(ResultGoToSignIn()));

    on<EventConfirmClick>((event, emit) async {
      await signUpUseCase(
        email: state.email.value,
        nickname: state.nickname.value,
        password: state.password.value,
        onSuccess: doNothing, // handled by AuthRepository.signedInChanges
        onFailure: (err) {
          // TODO: show error dialog
        },
      );
    });

    on<EventEmailChange>((event, emit) {
      textChangeUseCase(
        next: event.email,
        errorPredicate: (txt) => txt.isBlank,
        update: (textContainer) => emit(state.copyWith(email: textContainer)),
      );
    });

    on<EventNicknameChange>((event, emit) {
      textChangeUseCase(
        next: event.nickname,
        errorPredicate: (txt) => txt.isBlank,
        update: (textContainer) => emit(state.copyWith(nickname: textContainer)),
      );
    });

    on<EventPasswordChange>((event, emit) {
      textChangeUseCase(
        next: event.password,
        errorPredicate: (text) => state.isSmallForPassword(text),
        update: (textContainer) => emit(state.copyWith(password: textContainer)),
      );
    });
  }
}
