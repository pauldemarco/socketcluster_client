import 'dart:io';
import 'socket_platform.dart';

const IoSocketPlatform ioSocketPlatform = const IoSocketPlatform();
class IoSocketPlatform extends SocketPlatform {
  const IoSocketPlatform();

  Function webSocket([url]) => WebSocket.connect;
}
