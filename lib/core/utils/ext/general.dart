extension General<T> on T {
  R let<R>(R Function(T) transform) => transform(this);

  T? takeIf(bool Function(T) predicate) => predicate(this) ? this : null;
}
