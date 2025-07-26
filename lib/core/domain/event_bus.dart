import 'dart:async';

abstract interface class EventBus<E extends Object> {
  void sendEvent(E event);

  StreamSubscription<E> listen(void Function(E) onEvent);
}
