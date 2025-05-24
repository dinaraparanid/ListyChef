import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/auth/presentation/bloc/mod.dart';

final class AuthScreen extends StatelessWidget {
  final AuthBlocFactory blocFactory;
  final Widget child;

  const AuthScreen({
    super.key,
    required this.blocFactory,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => blocFactory.create(),
    child: child,
  );
}
