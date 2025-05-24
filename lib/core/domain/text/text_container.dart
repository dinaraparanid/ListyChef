import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_container.freezed.dart';

@freezed
abstract class TextContainer<E> with _$TextContainer<E> {
  const factory TextContainer({
    required String value,
    required E error,
  }) = _TextContainer<E>;
}
