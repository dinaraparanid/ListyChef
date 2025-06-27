sealed class CartEvent {}

final class EventSearchQueryChange extends CartEvent {
  final String query;
  EventSearchQueryChange({required this.query});
}

final class EventAddProduct extends CartEvent {}
