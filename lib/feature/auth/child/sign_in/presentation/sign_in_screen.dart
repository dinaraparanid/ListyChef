import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/auth/child/sign_in/presentation/bloc/sign_in_bloc_factory.dart';

final class SignInScreen extends StatelessWidget {
  final SignInBlocFactory blocFactory;
  const SignInScreen({super.key, required this.blocFactory});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => blocFactory.create(),
    child: Scaffold(
      extendBody: true,
      body: Text('TODO: SignInContent'),
    ),
  );
}
