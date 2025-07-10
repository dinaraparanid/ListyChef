import 'package:fast_immutable_collections/fast_immutable_collections.dart';

extension IListExt<T> on IList<T>? {
  IList<T> get orEmpty => this ?? const IList.empty();
}
