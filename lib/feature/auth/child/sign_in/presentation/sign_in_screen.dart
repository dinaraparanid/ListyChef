import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/scaffold/app_scaffold.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/functions/distinct_state.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/widget/sign_in_content.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_event.dart';
import 'package:listy_chef/feature/auth/presentation/widget/auth_error_message.dart';

final class SignInScreen extends StatelessWidget {
  final String? email;
  final SignInBlocFactory blocFactory;

  const SignInScreen({
    super.key,
    this.email,
    required this.blocFactory,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => blocFactory.create(
      onResult: (result) => BlocProvider
        .of<AuthBloc>(context)
        .add(EventHandleSignInResult(result: result)),
    ),
    child: BlocBuilder<SignInBloc, SignInState>(
      buildWhen: distinctState((s) => s.email.value),
      builder: (context, state) => BlocPresentationListener<SignInBloc, SignInEffect>(
        listener: (context, effect) async => switch (effect) {
          EffectShowAuthErrorDialog() => await showAuthErrorMessage(
            context: context,
            email: state.email.value,
            error: effect.error,
          ),

          EffectClearEmail() => doNothing,
        },
        child: AppScaffold(
          backgroundColor: context.appTheme.colors.background.primary,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: SignInContent(initialEmail: email),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
