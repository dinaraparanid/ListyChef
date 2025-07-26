import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/auth/entity/email.dart';

part 'product_data.freezed.dart';

@freezed
abstract class ProductData with _$ProductData {
  const factory ProductData({
    required bool isAdded,
    required Email? email,
    required String value,
    required int timestamp,
  }) = _ProductData;
}
