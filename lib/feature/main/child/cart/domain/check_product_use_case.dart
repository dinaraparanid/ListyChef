import 'package:listy_chef/core/domain/cart/entity/product_id.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';

final class CheckProductUseCase {
  final CartRepository _cartRepository;

  CheckProductUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  Future<void> call({
    required ProductId id,
    required void Function() onError,
  }) => _cartRepository.checkProduct(id: id).catchError((e) {
    AppLogger.value.e('Error during product check', error: e);
    onError();
  });
}
