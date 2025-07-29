import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';

abstract interface class CartDataSource {
  Future<IList<Product>> todoProducts({required Email email});
  Future<IList<Product>> addedProducts({required Email email});
  Future<void> checkProduct({required ProductId id});
  Future<void> removeProduct({required ProductId id});
  Future<void> addProduct({required ProductData data});
  Future<void> updateProduct({
    required ProductId id,
    required ProductData newData,
  });
}
