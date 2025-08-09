import 'dart:async';
import 'package:listy_chef/core/domain/event_bus.dart';

sealed class LoadFolderItemsEvent {}

final class EventRefresh extends LoadFolderItemsEvent {}

final class LoadFolderItemsEventBus implements EventBus<LoadFolderItemsEvent> {
  final _controller = StreamController<LoadFolderItemsEvent>.broadcast();

  @override
  void sendEvent(LoadFolderItemsEvent event) => _controller.add(event);

  @override
  StreamSubscription<LoadFolderItemsEvent> listen(
    void Function(LoadFolderItemsEvent) onEvent,
  ) => _controller.stream.listen(onEvent);
}