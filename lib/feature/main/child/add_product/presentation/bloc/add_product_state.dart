import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';

part 'add_product_state.freezed.dart';

@freezed
abstract class AddProductState with _$AddProductState {
  const factory AddProductState({
    @Default(TextContainer(value: '', error: false))
    TextContainer<bool> productTitle,
  }) = _AddProductState;
}

extension Properties on AddProductState {
  bool get isConfirmButtonEnabled =>
    productTitle.value.isNotBlank && productTitle.error.not;
}
