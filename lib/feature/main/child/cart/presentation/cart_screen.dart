import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/mod.dart';

final class CartScreen extends StatelessWidget {
  final CartBlocFactory blocFactory;

  const CartScreen({
    super.key,
    required this.blocFactory,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => blocFactory(),
    child: Stack(
      alignment: Alignment.center,
      children: [Text('TODO: CartScreen')],
    ),
  );
}
