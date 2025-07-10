bool Function(S, S) distinctState<S, R>(R Function(S) transform) =>
  (x, y) => transform(x) != transform(y);

bool Function(S, S) ignoreState<S>() => (_, _) => false;
