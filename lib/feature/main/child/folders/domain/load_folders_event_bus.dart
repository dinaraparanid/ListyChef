import 'dart:async';
import 'package:listy_chef/core/domain/event_bus.dart';

sealed class LoadFoldersEvent {}

final class EventRefresh extends LoadFoldersEvent {}

final class LoadFoldersEventBus implements EventBus<LoadFoldersEvent> {
  final _controller = StreamController<LoadFoldersEvent>.broadcast();

  @override
  void sendEvent(LoadFoldersEvent event) => _controller.add(event);

  @override
  StreamSubscription<LoadFoldersEvent> listen(
    void Function(LoadFoldersEvent) onEvent,
  ) => _controller.stream.listen(onEvent);
}
