import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listy_chef/feature/main/child/cart/presentation/bloc/cart_event.dart';

final class CartBloc extends Bloc<CartEvent, void> {
  CartBloc() : super(null) {
    on<AddProduct>((event, emit) {
      // TODO
    });
  }
}
