import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';
import 'package:listy_chef/core/presentation/foundation/ui_state.dart';
import 'package:rxdart/rxdart.dart';

final class LoadCartListsUseCase {
  final CartRepository _cartRepository;
  final AuthRepository _authRepository;

  LoadCartListsUseCase({
    required CartRepository cartRepository,
    required AuthRepository authRepository,
  }) : _cartRepository = cartRepository,
    _authRepository = authRepository;

  StreamSubscription<(UiState<IList<Product>>, UiState<IList<Product>>)> call({
    required void Function(
      UiState<IList<Product>> todoProductsState,
      UiState<IList<Product>> addedProductsState,
    ) updateState,
  }) => _authRepository
    .emailChanges
    .whereType<Email>()
    .flatMap((email) => CombineLatestStream.combine2(
      _cartRepository.todoProducts(email: email),
      _cartRepository.addedProducts(email: email),
      (todoProducts, addedProducts) => (
        todoProducts.toUiState(),
        addedProducts.toUiState(),
      ),
    ))
    .distinct()
    .listen((states) => updateState(states.$1, states.$2));
}
