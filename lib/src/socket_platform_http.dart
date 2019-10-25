import 'dart:html';

import 'socket_platform_interface.dart' as socketinterface;

const HttpSocketPlatform httpSocketPlatform = const HttpSocketPlatform();
class HttpSocketPlatform extends socketinterface.HttpSocketPlatform {
  const HttpSocketPlatform();

  @override
  dynamic webSocket([url]) => new WebSocket(url);
}

const socketinterface.SocketPlatform RuntimeSocketPlatform = httpSocketPlatform;
