import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:listy_chef/navigation/app_route.dart';
import 'package:listy_chef/navigation/app_router.dart';

final class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required AppRouter router,
    required TextChangeUseCase textChangeUseCase,
  }) : super(SignInState()) {
    on<EventSignUpClick>((event, emit) =>
      router.value.replaceNamed(AppRoute.signUp.name),
    );

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

    on<EventPasswordChange>((event, emit) {
      textChangeUseCase.execute(
        next: event.password,
        errorPredicate: (_) => false,
        update: (textContainer) => emit(state.copyWith(password: textContainer)),
      );
    });
  }
}
