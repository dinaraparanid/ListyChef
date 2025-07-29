import 'package:listy_chef/core/domain/auth/repository/auth_repository.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class AddProductUseCase {
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
    .firestoreTimeout()
    .then((_) => onSuccess())
    .catchError((e) {
      AppLogger.value.e('Error during product add', error: e);
      onError();
    });
}
