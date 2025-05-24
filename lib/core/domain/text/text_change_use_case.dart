import 'package:listy_chef/core/domain/text/text_container.dart';

final class TextChangeUseCase {
  void execute<E>({
    required String next,
    required E Function(String next) errorPredicate,
    required void Function(TextContainer<E>) update,
  }) => update(TextContainer(value: next, error: errorPredicate(next)));
}
