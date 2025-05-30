import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/app_scaffold.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_bloc_factory.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/widget/sign_in_content.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/auth_event.dart';

final class SignInScreen extends StatelessWidget {
  final SignInBlocFactory blocFactory;
  const SignInScreen({super.key, required this.blocFactory});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => blocFactory.create(
      onResult: (result) => BlocProvider
        .of<AuthBloc>(context)
        .add(EventHandleSignInResult(result: result)),
    ),
    child: AppScaffold(
      backgroundColor: context.appTheme.colors.background.primary,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SignInContent(),
          ),
        ],
      ),
    ),
  );
}
