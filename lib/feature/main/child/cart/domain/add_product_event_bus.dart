import 'dart:async';
import 'package:listy_chef/core/domain/event_bus.dart';

sealed class AddProductEvent {}

final class EventRefreshLists extends AddProductEvent {}

final class AddProductEventBus implements EventBus<AddProductEvent> {
  final _controller = StreamController<AddProductEvent>();

  @override
  void sendEvent(AddProductEvent event) => _controller.add(event);

  @override
  StreamSubscription<AddProductEvent> listen(
    void Function(AddProductEvent) onEvent,
  ) => _controller.stream.listen(onEvent);
}