import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';

final class AddProductUseCase {
  static const _timeout = Duration(seconds: 1);

  final CartRepository _cartRepository;
  final AuthRepository _authRepository;

  AddProductUseCase({
    required CartRepository cartRepository,
    required AuthRepository authRepository,
  }) : _cartRepository = cartRepository, _authRepository = authRepository;

  Future<void> call({
    required String productTitle,
    required void Function() onSuccess,
    required void Function() onError,
  }) => _cartRepository
    .addProduct(
      data: ProductData(
        isAdded: false,
        email: _authRepository.email,
        value: productTitle,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    )
    .timeout(_timeout, onTimeout: doNothing)
    .then((_) => onSuccess())
    .catchError((e) {
      AppLogger.value.e('Error during product add', error: e);
      onError();
    });
}
