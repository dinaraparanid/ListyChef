import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listy_chef/core/domain/text/text_container.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default(TextContainer(value: '', error: null))
    TextContainer<void> searchQuery,
  }) = _CartState;
}
