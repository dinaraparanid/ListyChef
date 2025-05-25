import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_result.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/sign_up_state.dart';

final class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required TextChangeUseCase textChangeUseCase,
    required void Function(SignUpResult) onResult,
  }) : super(SignUpState()) {
    on<EventBack>((event, emit) => onResult(ResultGoToSignIn()));

    on<EventConfirmClick>((event, emit) {
      // TODO
    });

    on<EventEmailChange>((event, emit) {
      textChangeUseCase.execute(
        next: event.email,
        errorPredicate: (txt) => txt.isBlank,
        update: (textContainer) => emit(state.copyWith(email: textContainer)),
      );
    });

    on<EventNicknameChange>((event, emit) {
      textChangeUseCase.execute(
        next: event.nickname,
        errorPredicate: (txt) => txt.isBlank,
        update: (textContainer) => emit(state.copyWith(nickname: textContainer)),
      );
    });

    on<EventPasswordChange>((event, emit) {
      textChangeUseCase.execute(
        next: event.password,
        errorPredicate: (text) => state.isSmallForPassword(text),
        update: (textContainer) => emit(state.copyWith(password: textContainer)),
      );
    });
  }
}
