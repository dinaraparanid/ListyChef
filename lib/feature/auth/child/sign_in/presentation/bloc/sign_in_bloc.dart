import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_effect.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_result.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:listy_chef/feature/auth/domain/sign_in_use_case.dart';

final class SignInBloc extends Bloc<SignInEvent, SignInState>
  with BlocPresentationMixin<SignInState, SignInEffect> {

  SignInBloc({
    String? email,
    required SignInUseCase signInUseCase,
    required TextChangeUseCase textChangeUseCase,
    required void Function(SignInResult) onResult,
  }) : super(SignInState(email: TextContainer(value: email ?? '', error: false))) {
    on<EventSignUpClick>((event, emit) =>
      onResult(ResultGoToSignUp(email: state.email.value)),
    );

    on<EventConfirmClick>((event, emit) async {
      await signInUseCase(
        email: state.email.value,
        password: state.password.value,
        onSuccess: doNothing, // handled by AuthRepository.signedInChanges
        onFailure: (err) => emitPresentation(EffectShowAuthErrorDialog(error: err)),
      );
    });

    on<EventEmailChange>((event, emit) {
      textChangeUseCase(
        next: event.email,
        errorPredicate: (txt) => txt.isBlank,
        update: (textContainer) => emit(state.copyWith(email: textContainer)),
      );
    });

    on<EventPasswordChange>((event, emit) {
      textChangeUseCase(
        next: event.password,
        errorPredicate: (text) => state.isSmallForPassword(text),
        update: (textContainer) => emit(state.copyWith(password: textContainer)),
      );
    });

    on<EventClearEmail>((event, emit) {
      emit(state.copyWith(email: TextContainer(value: '', error: false)));
      emitPresentation(EffectClearEmail());
    });

    on<EventChangePasswordVisibility>((event, emit) =>
      emit(state.copyWith(isPasswordVisible: state.isPasswordVisible.not)),
    );
  }
}
