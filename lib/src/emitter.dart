

typedef Listener(String name, dynamic data);

typedef AckListener(String name, dynamic data, AckCall ack);

typedef AckCall(String name, dynamic error, dynamic data);

class Emitter {
  final Map<String, Listener> _singleCallbacks = new Map();
  final Map<String, AckListener> _singleAckCallbacks = new Map();
  final Map<String, Listener> _publishCallbacks = new Map();

  Emitter on(String event, Function func) {
    if(func is Listener) {
      _on(event, func);
    } else if(func is AckListener) {
      _onAck(event, func);
    } else {
      throw new Exception('on(event, func) - func incorrect format');
    }
    return this;
  }

  Emitter _on(String event, Listener fn) {
    if (_singleCallbacks.containsKey(event)) _singleCallbacks.remove(event);

    _singleCallbacks[event] = fn;
    return this;
  }

  Emitter _onAck(String event, AckListener fn) {
    if (_singleAckCallbacks.containsKey(event))
      _singleAckCallbacks.remove(event);

    _singleAckCallbacks[event] = fn;
    return this;
  }

  Emitter onSubscribe(String event, Listener fn) {
    if (_publishCallbacks.containsKey(event)) _publishCallbacks.remove(event);

    _publishCallbacks[event] = fn;
    return this;
  }

  Emitter handleEmit(String event, dynamic object) {
    if (_singleCallbacks.containsKey(event)) {
      var listener = _singleCallbacks[event];
      listener(event, object);
    }
    return this;
  }

  Emitter handleEmitAck(String event, dynamic object, AckCall ack) {
    if (_singleAckCallbacks.containsKey(event)) {
      var listener = _singleAckCallbacks[event];
      listener(event, object, ack);
    }
    return this;
  }

  Emitter handlePublish(String event, dynamic object) {
    if (_publishCallbacks.containsKey(event)) {
      var listener = _publishCallbacks[event];
      listener(event, object);
    }
    return this;
  }

  bool hasEventAck(String event) => _singleAckCallbacks.containsKey(event);
}
