extension BoolExt on bool {
  bool get not => !this;

  T? ifTrue<T>(T? value) => this ? value : null;
  T? produceIfTrue<T>(T? Function() action) => this ? action() : null;

  T? ifFalse<T>(T? value) => this ? null : value;
  T? produceIfFalse<T>(T? Function() action) => this ? null : action();
}
