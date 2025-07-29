import 'package:listy_chef/core/domain/cart/entity/product_id.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class DeleteProductUseCase {
  final CartRepository _cartRepository;

  DeleteProductUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  Future<void> call({
    required ProductId id,
    required void Function() onSuccess,
    required void Function() onFailure,
  }) => _cartRepository
    .removeProduct(id: id)
    .firestoreTimeout()
    .then((_) => onSuccess())
    .catchError((e) {
      AppLogger.value.e('Error during product delete', error: e);
      onFailure();
    });
}
