import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_scaffold.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/widget/sign_up_content.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_event.dart';
import 'package:listy_chef/feature/auth/presentation/widget/auth_error_message.dart';

final class SignUpScreen extends StatelessWidget {
  final String? email;
  final SignUpBlocFactory blocFactory;

  const SignUpScreen({
    super.key,
    this.email,
    required this.blocFactory,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => blocFactory.create(
      email: email,
      onResult: (result) => BlocProvider
        .of<AuthBloc>(context)
        .add(EventHandleSignUpResult(result: result)),
    ),
    child: BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: distinctState((s) => s.email),
      builder: (context, state) => BlocPresentationListener<SignUpBloc, SignUpEffect>(
        listener: (context, effect) => switch (effect) {
          EffectShowAuthErrorDialog() => showAuthErrorMessage(
            context: context,
            email: state.email.value,
            error: effect.error,
            onEmailAlreadyInUse: (context) => BlocProvider
              .of<AuthBloc>(context)
              .add(EventNavigateToSignIn(email: state.email.value)),
          ),

          EffectClearEmail() || EffectClearNickname() => doNothing,
        },
        child: AppScaffold(
          backgroundColor: context.appTheme.colors.background.primary,
          onBack: () => BlocProvider
            .of<SignUpBloc>(context)
            .add(EventBack()),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: SignUpContent(initialEmail: email),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
