import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/cart/entity/product_data.dart';
import 'package:listy_chef/core/domain/cart/entity/product_id.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  static const firestoreFieldEmail = 'email';
  static const firestoreFieldProduct = 'product';
  static const firestoreFieldAdded = 'added';
  static const firestoreFieldTimestamp = 'timestamp';

  const factory Product({
    required ProductId id,
    required ProductData data,
  }) = _Product;
}
