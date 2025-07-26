import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/cart/data_source/cart_data_source.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';

final class CartRepositoryImpl implements CartRepository {
  final CartDataSource _firestoreDataSource;

  CartRepositoryImpl({
    required CartDataSource firestoreDataSource,
  }) : _firestoreDataSource = firestoreDataSource;

  @override
  Future<IList<Product>> addedProducts({required Email email}) async {
    return await _firestoreDataSource.addedProducts(email: email);
  }

  @override
  Future<IList<Product>> todoProducts({required Email email}) async {
    return await _firestoreDataSource.todoProducts(email: email);
  }

  @override
  Future<void> checkProduct({required ProductId id}) async {
    await _firestoreDataSource.checkProduct(id: id);
  }

  @override
  Future<void> removeProduct({required ProductId id}) async {
    await _firestoreDataSource.removeProduct(id: id);
  }

  @override
  Future<void> addProduct({required ProductData data}) async {
    await _firestoreDataSource.addProduct(data: data);
  }
}
