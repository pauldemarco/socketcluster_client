part of socketcluster_client;

class Socket extends Emitter {
  WebSocket _socket;
  String url;
  String id;
  final ReconnectStrategy strategy;
  final BasicListener listener;
  int _counter = 0;
  String authToken;
  final List<Channel> channels = new List();
  final Map<int, List<dynamic>> _acks = new Map();

  int get state => _socket.readyState ?? CLOSED;

  static const int CONNECTING = 0;
  static const int OPEN = 1;
  static const int CLOSING = 2;
  static const int CLOSED = 3;

  /*Socket(this.url, this.listener, {this.authToken, this.strategy});

  connect() {
    WebSocket.connect(url)
        .then(onSocketOpened)
        .catchError((e) => listener.onConnectError(this, e));
  }*/

  Socket._internal(this._socket,
      {this.authToken, this.strategy, this.listener}) {
    _socket.listen(handleMessage).onDone(onSocketDone);
    onSocketOpened();
  }

  static Future<Socket> connect(String url,
      {String authToken,
      ReconnectStrategy strategy,
      BasicListener listener}) async {
    var socket = await WebSocket.connect(url);
    return new Socket._internal(socket,
        authToken: authToken, strategy: strategy, listener: listener);
  }

  void setProxy(String host, int port) {
    throw new UnimplementedError();
    /*var proxy = new HttpConnectProxy(new IPEndPoint(IPAddress.Parse(host), port));
    _socket.Proxy = (SuperSocket.ClientEngine.IProxyConnector)proxy;*/
  }

  void setSSLCertVerification(bool value) {
    throw new UnimplementedError();
    //_socket.AllowUnstrustedCertificate = value;
  }

  void onSocketOpened() {
    _counter = 0;
    strategy?.attmptsMade = 0;
    var authObject = {
      'event': '#handshake',
      'data': {
        'authToken': authToken,
      },
      'cid': ++_counter
    };
    // Note: ported C# code had Formatting.Indented parameter
    var json = JSON.encode(authObject);
    _socket.add(json);
    listener.onConnected(this);
  }

  void onSocketDone() {
    listener.onDisconnected(this);
  }

  Channel createChannel(String name) {
    var channel = new Channel(this, name);
    channels.add(channel);
    return channel;
  }

  void handleMessage(dynamic message) {
    if (message == "#1") {
      _socket.add("#2");
    } else {
//      print('Message received: $message');

      var map = JSON.decode(message);
      var data = map['data'];
      int rid = map['rid'];
      int cid = map['cid'];
      String event = map['event'];

//      print('Event: $event, rid: $rid, cid: $cid, data: $data');

      switch (Parser.parse(data, rid, cid, event)) {
        case ParseResult.ISAUTHENTICATED:
//          print('IS authenticated got called');
          id = data['id'];
          listener.onAuthentication(this, data['isAuthenticated']);
          subscribeChannels();
          break;
        case ParseResult.PUBLISH:
          handlePublish(data['channel'], data['data']);
//          print('Publish got called');
          break;
        case ParseResult.REMOVETOKEN:
          authToken = null;
//          print('Removetoken got called');
          break;
        case ParseResult.SETTOKEN:
          listener.onSetAuthToken(data['token'], this);
//          print('Set token got called');
          break;
        case ParseResult.EVENT:
          if (hasEventAck(event)) {
            handleEmitAck(event, data, ack(cid));
          } else {
            handleEmit(event, data);
          }
          break;
        case ParseResult.ACKRECEIVE:
//          print('Ack receive got called');
          if (_acks.containsKey(rid)) {
            var mapObj = _acks[rid];
            _acks.remove(rid);
            if (mapObj != null) {
              AckCall fn = mapObj[1];
              if (fn != null) {
                fn(mapObj[0], map['error'], map['data']);
              } else {
//                print('Ack function is null');
              }
            }
          }
          break;
        default:
          throw new RangeError('Unknown ParseResult');
      }
    }
  }

  AckCall ack(int cid) {
    return (name, error, data) {
      var message = {
        'error': error,
        'data': data,
        'rid': cid, // FIXME: rid -> cid?
      };
      var json = JSON.encode(message);
      _socket.add(json);
    };
  }

  Socket emit(String event, dynamic data, [AckCall ack]) {
    int count = ++_counter;
    var message = {'event': event, 'data': data};
    if (ack != null) {
      message['cid'] = count;
      _acks[count] = getAckObject(event, ack);
    }
    var json = JSON.encode(message);
//    print(json);
    _socket.add(json);
    return this;
  }

  Socket subscribe(String channel, [AckCall ack]) {
    int count = ++_counter;
    var message = {
      'event': '#subscribe',
      'data': {'channel': channel},
      'cid': count
    };
    if (ack != null) _acks[count] = getAckObject(channel, ack);
    var json = JSON.encode(message);
    _socket.add(json);
    return this;
  }

  Socket unsubscribe(String channel, [AckCall ack]) {
    int count = ++_counter;
    var message = {'event': '#unsubscribe', 'data': channel, 'cid': count};
    if (ack != null) _acks[count] = getAckObject(channel, ack);
    var json = JSON.encode(message);
    _socket.add(json);
    return this;
  }

  Socket publish(String channel, dynamic data, [AckCall ack]) {
    int count = ++_counter;
    var message = {
      'event': '#publish',
      'data': {'channel': channel, 'data': data},
      'cid': count
    };
    if (ack != null) _acks[count] = getAckObject(channel, ack);
    var json = JSON.encode(message);
    _socket.add(json);
    return this;
  }

  List<dynamic> getAckObject(String event, AckCall ack) {
    return [event, ack];
  }

  void subscribeChannels() {
    channels.forEach((c) => c.subscribe());
  }
}
