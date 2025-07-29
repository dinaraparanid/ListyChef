import 'dart:async';
import 'package:listy_chef/core/domain/event_bus.dart';

sealed class LoadCartListsEvent {}

final class EventRefreshLists extends LoadCartListsEvent {}

final class LoadCartListsEventBus implements EventBus<LoadCartListsEvent> {
  final _controller = StreamController<LoadCartListsEvent>.broadcast();

  @override
  void sendEvent(LoadCartListsEvent event) => _controller.add(event);

  @override
  StreamSubscription<LoadCartListsEvent> listen(
    void Function(LoadCartListsEvent) onEvent,
  ) => _controller.stream.listen(onEvent);
}