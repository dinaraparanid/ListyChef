import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/app_scaffold.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/bloc/mod.dart';
import 'package:listy_chef/feature/auth/child/sign_up/presentation/widget/sign_up_content.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_event.dart';

final class SignUpScreen extends StatelessWidget {
  final SignUpBlocFactory blocFactory;
  const SignUpScreen({super.key, required this.blocFactory});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => blocFactory.create(
      onResult: (result) => BlocProvider
        .of<AuthBloc>(context)
        .add(EventHandleSignUpResult(result: result)),
    ),
    child: BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, _) => AppScaffold(
        backgroundColor: context.appTheme.colors.background.primary,
        onBack: () => BlocProvider
          .of<SignUpBloc>(context)
          .add(EventBack()),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: SignUpContent(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
