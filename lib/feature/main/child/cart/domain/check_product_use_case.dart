import 'package:listy_chef/core/domain/cart/entity/product_id.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';

final class CheckProductUseCase {
  final CartRepository _cartRepository;

  CheckProductUseCase({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  Future<void> call({required ProductId id}) =>
    _cartRepository.checkProduct(id: id);
}
