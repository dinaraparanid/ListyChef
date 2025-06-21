import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/cart/entity/product_id.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  static const firestoreFieldEmail = 'email';
  static const firestoreFieldProduct = 'product';
  static const firestoreFieldAdded = 'added';

  const factory Product({
    required ProductId id,
    required String value,
    required bool isAdded,
  }) = _Product;
}
