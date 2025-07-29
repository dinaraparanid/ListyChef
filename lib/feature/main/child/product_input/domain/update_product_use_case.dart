import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/core/utils/ext/firestore_operation_timeout.dart';

final class UpdateProductUseCase {
  final CartRepository _cartRepository;

  UpdateProductUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  Future<void> call({
    required ProductId id,
    required ProductData previousData,
    required String productTitle,
    required void Function() onSuccess,
    required void Function() onError,
  }) => _cartRepository
    .updateProduct(
      id: id,
      newData: ProductData(
        isAdded: previousData.isAdded,
        email: previousData.email,
        value: productTitle,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    )
    .firestoreTimeout()
    .then((_) => onSuccess())
    .catchError((e) {
      AppLogger.value.e('Error during product update', error: e);
      onError();
    });
}
