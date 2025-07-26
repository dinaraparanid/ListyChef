import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';
import 'package:listy_chef/core/domain/cart/entity/product.dart';
import 'package:listy_chef/core/domain/cart/entity/product_data.dart';
import 'package:listy_chef/core/domain/cart/entity/product_id.dart';
import 'package:listy_chef/core/utils/ext/dynamic_ext.dart';

extension ProductsFromFirestoreMapper on QuerySnapshot<Map<String, dynamic>> {
  IList<Product> toProductList() =>
    docs.mapNotNull((doc) => doc?.toProduct()).toIList();
}

extension ProductFromFirestoreMapper on QueryDocumentSnapshot<Map<String, dynamic>> {
  Product? toProduct() {
    final data = this.data();
    final id = ProductId(this.id);
    final isAdded = asOrNull<bool>(data[Product.firestoreFieldAdded]);
    final email = asOrNull<Email>(data[Product.firestoreFieldEmail]);
    final value = asOrNull<String>(data[Product.firestoreFieldProduct]);
    final timestamp = asOrNull<int>(data[Product.firestoreFieldTimestamp]) ?? 0;

    if (isAdded == null || email == null || value == null) {
      return null;
    }

    return Product(
      id: id,
      data: ProductData(
        isAdded: isAdded,
        email: email,
        value: value,
        timestamp: timestamp,
      ),
    );
  }
}

extension ProductToFirestoreMapper on ProductData {
  Map<String, dynamic> toFirestoreData() => {
    Product.firestoreFieldAdded: isAdded,
    Product.firestoreFieldEmail: email,
    Product.firestoreFieldProduct: value,
    Product.firestoreFieldTimestamp: timestamp,
  };
}
