import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/data/cart/mapper/product_mapper.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/domain/cart/entity/product_id.dart';
import 'package:listy_chef/core/domain/cart/repository/cart_repository.dart';
import 'package:listy_chef/core/utils/ext/dynamic_ext.dart';

const _collectionCart = 'cart';

final class CartRepositoryImpl implements CartRepository {
  @override
  Stream<IList<Product>> addedProducts({required Email email}) =>
    _products(email: email, isAdded: true);

  @override
  Stream<IList<Product>> todoProducts({required Email email}) =>
    _products(email: email, isAdded: false);

  @override
  Future<void> checkProduct({required ProductId id}) async {
    final docRef = _productsCollection().doc(id.value);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.get(docRef).then((doc) {
        final nextAdded = asOrNull<bool>(doc[Product.firestoreFieldAdded]) ?? false;
        transaction.update(docRef, { Product.firestoreFieldAdded: nextAdded });
      });
    });
  }

  @override
  Future<void> removeProduct({required ProductId id}) =>
    _productsCollection().doc(id.value).delete();

  CollectionReference<Map<String, dynamic>> _productsCollection() =>
    FirebaseFirestore.instance.collection(_collectionCart);

  Stream<IList<Product>> _products({
    required Email email,
    required bool isAdded,
  }) => _productsCollection()
    .where(Product.firestoreFieldEmail, isEqualTo: email.value)
    .where(Product.firestoreFieldAdded, isEqualTo: isAdded)
    .snapshots()
    .map((snapshot) => snapshot.toProductList())
    .distinct();
}
