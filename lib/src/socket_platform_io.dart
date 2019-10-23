import 'dart:io';

import 'socket_platform_interface.dart' as socketinterface;

const IoSocketPlatform ioSocketPlatform = const IoSocketPlatform();
class IoSocketPlatform extends socketinterface.IoSocketPlatform {
  const IoSocketPlatform();

  Function webSocket([url]) => WebSocket.connect;
}

const socketinterface.SocketPlatform RuntimeSocketPlatform = ioSocketPlatform;
