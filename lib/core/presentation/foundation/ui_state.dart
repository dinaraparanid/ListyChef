import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state.freezed.dart';

@freezed
sealed class UiState<T> with _$UiState<T> {
  const factory UiState.initial() = Initial<T>;
  const factory UiState.loading() = Loading<T>;
  const factory UiState.refreshing({required UiState<T> value}) = Refreshing<T>;
  const factory UiState.data({required T value}) = Data<T>;
  const factory UiState.success() = Success<T>;
  const factory UiState.error([Exception? e]) = Error<T>;

  factory UiState.flattenRefreshing({required UiState<T> value}) =>
    switch (value) {
      Refreshing<T>() => value,
      _ => UiState.refreshing(value: value),
    };
}

extension Properties<T> on UiState<T> {
  T? get getOrNull => switch (this) {
    Initial() => null,
    Loading() => null,
    Error() => null,
    Success() => null,
    Refreshing() => (this as Refreshing<T>).value.getOrNull,
    Data() => (this as Data<T>).value,
  };

  bool get isInitial => this is Initial;
  bool get isLoading => this is Loading;
  bool get isError => this is Error;
  bool get isSuccess => this is Success;
  bool get isData => this is Data;
  bool get isRefreshing => this is Refreshing;
  bool get isEvaluating => isInitial || isLoading || isRefreshing;

  UiState<R> mapData<R>(R Function(T) transform) => switch (this) {
    Initial() => Initial(),
    Loading() => Loading(),
    Refreshing(value: final state) => Refreshing(value: state.mapData(transform)),
    Data(value: final value) => Data(value: transform(value)),
    Success() => Success(),
    Error(e: final e) => Error(e),
  };

  UiState<R> flatMap<R>(UiState<R> Function(T) transform) => switch (this) {
    Initial() => Initial(),
    Loading() => Loading(),
    Data(value: final value) => transform(value),
    Success() => Success(),
    Error(e: final e) => Error(e),
    Refreshing(value: final state) =>
      UiState.flattenRefreshing(value: state.flatMap(transform)),
  };
}

extension Mapper<T> on T {
  Data<T> toUiState() => Data(value: this);
}

extension Flatten<T> on UiState<UiState<T>> {
  UiState<T> get flatten => switch (this) {
    Initial<UiState<T>>() => Initial(),
    Loading<UiState<T>>() => Loading(),
    Refreshing<UiState<T>>(value: final state) => state.flatten,
    Data<UiState<T>>(value: final state) => state,
    Success<UiState<T>>() => Success(),
    Error<UiState<T>>(e: final e) => Error(e),
  };
}
