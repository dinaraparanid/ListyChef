import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/presentation/foundation/app_scaffold.dart';
import 'package:listy_chef/feature/main/presentation/bloc/main_bloc_factory.dart';

final class MainScreen extends StatelessWidget {
  final MainBlocFactory blocFactory;
  final Widget child;

  const MainScreen({
    super.key,
    required this.blocFactory,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => blocFactory.create(),
    child: AppScaffold(
      body: child, // TODO навигация + sizer для разных размеров экранов
    ),
  );
}
