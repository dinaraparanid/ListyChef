import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/cart/entity/mod.dart';
import 'package:listy_chef/core/domain/cart/entity/product_id.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';

part 'product_input_state.freezed.dart';

@freezed
abstract class ProductInputState with _$ProductInputState {
  const factory ProductInputState({
    required ProductInputMode mode,

    ProductId? id,
    ProductData? previousData,

    @Default(TextContainer(value: '', error: false))
    TextContainer<bool> productTitle,
  }) = _ProductInputState;
}

enum ProductInputMode { create, update }

extension Properties on ProductInputState {
  bool get isConfirmButtonEnabled =>
    productTitle.value.isNotBlank && productTitle.error.not;
}
