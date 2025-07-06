import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/domain/cart/entity/product_id.dart';
import 'package:listy_chef/core/utils/ext/dynamic_ext.dart';

extension ProductsMapper on QuerySnapshot<Map<String, dynamic>> {
  IList<Product> toProductList() =>
    docs.mapNotNull((doc) => doc?.toProduct()).toIList();
}

extension ProductMapper on QueryDocumentSnapshot<Map<String, dynamic>> {
  Product? toProduct() {
    final data = this.data();
    final id = ProductId(this.id);
    final value = asOrNull<String>(data[Product.firestoreFieldProduct]);
    final isAdded = asOrNull<bool>(data[Product.firestoreFieldAdded]);
    final timestamp = asOrNull<int>(data[Product.firestoreFieldTimestamp]) ?? 0;

    if (value == null || isAdded == null) {
      return null;
    }

    return Product(
      id: id,
      value: value,
      isAdded: isAdded,
      timestamp: timestamp,
    );
  }
}
