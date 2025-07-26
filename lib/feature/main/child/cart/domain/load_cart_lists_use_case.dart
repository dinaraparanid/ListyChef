import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';

final class LoadCartListsUseCase {
  final CartRepository _cartRepository;
  final AuthRepository _authRepository;

  LoadCartListsUseCase({
    required CartRepository cartRepository,
    required AuthRepository authRepository,
  }) : _cartRepository = cartRepository,
    _authRepository = authRepository;

  Future<(UiState<IList<Product>>, UiState<IList<Product>>)> call() async {
    final email = _authRepository.email;

    if (email == null) {
      return (
        UiState<IList<Product>>.error(),
        UiState<IList<Product>>.error(),
      );
    }

    try {
      final products = await Future.wait([
        _cartRepository.todoProducts(email: email),
        _cartRepository.addedProducts(email: email),
      ]);

      return (products[0].toUiState(), products[1].toUiState());
    } catch (e) {
      return (
        UiState<IList<Product>>.error(),
        UiState<IList<Product>>.error(),
      );
    }
  }
}
