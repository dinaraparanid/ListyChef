import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_bloc.dart';

final class CartBlocFactory {
  final TextChangeUseCase _textChangeUseCase;

  CartBlocFactory({
    required TextChangeUseCase textChangeUseCase,
  }) : _textChangeUseCase = textChangeUseCase;

  CartBloc call() => CartBloc(
    textChangeUseCase: _textChangeUseCase,
  );
}
