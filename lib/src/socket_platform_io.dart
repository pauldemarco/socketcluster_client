import 'dart:io';

import 'socket_platform_interface.dart' show IoSocketPlatformType, SocketPlatform;
import 'socket_platform.dart';

const IoSocketPlatform ioSocketPlatform = const IoSocketPlatform();
class IoSocketPlatform extends IoSocketPlatformType {
  const IoSocketPlatform();

  Function webSocket([url]) => WebSocket.connect;
}

SocketPlatform globalSocketPlatform = ioSocketPlatform;
