import 'dart:html';

import 'socket_platform_interface.dart' show HttpSocketPlatformType, SocketPlatform;
import 'socket_platform.dart';

const HttpSocketPlatform httpSocketPlatform = const HttpSocketPlatform();
class HttpSocketPlatform extends HttpSocketPlatformType {
  const HttpSocketPlatform();

  @override
  dynamic webSocket([url]) => new WebSocket(url);
}

SocketPlatform globalSocketPlatform = httpSocketPlatform;
