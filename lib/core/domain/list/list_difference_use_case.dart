import 'package:diffutil_dart/diffutil.dart';

final class ListDifferenceUseCase {
  void call<T>({
    required IndexableItemDiffDelegate<T> delegate,
    void Function(int, T)? onInsert,
    void Function(int, T)? onRemove,
    void Function(int, T)? onChange,
  }) => calculateDiff<T>(delegate).getUpdatesWithData().forEach((act) =>
    act.when(
      insert: (i, t) => onInsert?.call(i, t),
      remove: (i, t) => onRemove?.call(i, t),
      change: (i, _, t) => onChange?.call(i, t),
      move: (_, _, _) {},
    ),
  );
}
