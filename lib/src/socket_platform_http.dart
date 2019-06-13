import 'dart:html';

import 'socket_platform.dart';

const HttpSocketPlatform httpSocketPlatform = const HttpSocketPlatform();
class HttpSocketPlatform extends SocketPlatform {
  const HttpSocketPlatform();

  @override
  dynamic webSocket([url]) => new WebSocket(url);
}
