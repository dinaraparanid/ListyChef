bool Function(S, S) distinctState<S, R>(R Function(S) transform) =>
  (x, y) => transform(x) != transform(y);
