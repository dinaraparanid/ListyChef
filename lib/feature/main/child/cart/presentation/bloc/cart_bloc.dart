import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/core/domain/text/text_change_use_case.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_event.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_state.dart';

final class CartBloc extends Bloc<CartEvent, CartState> {

  CartBloc({
    required TextChangeUseCase textChangeUseCase,
  }) : super(CartState()) {
    on<EventSearchQueryChange>((event, emit) {
      textChangeUseCase(
        next: event.query,
        errorPredicate: (_) => null,
        update: (textContainer) =>
          emit(state.copyWith(searchQuery: textContainer)),
      );
    });

    on<EventAddProduct>((event, emit) {
      // TODO
    });
  }
}
