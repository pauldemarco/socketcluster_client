import 'socket_platform_io.dart';
/// inherit this global one.
SocketPlatform get globalSocketPlatform => _globalSocketPlatform;
set globalSocketPlatform(SocketPlatform socketPlatform) {
  if (socketPlatform == null) {
    throw new ArgumentError('socket: Global socket platform '
        'implementation must not be null.');
  }
  // Todo: log the socket platform implementation
  _globalSocketPlatform = socketPlatform;
}
SocketPlatform _globalSocketPlatform = IoSocketPlatform();

/// Reset the globally configured socet platform.
void resetGlobalSocketPlatform() {
  _globalSocketPlatform = null;
}



abstract class SocketPlatform {
  const SocketPlatform();

  /// Constructs a new [WebSocket] instance.
  dynamic webSocket([url]);
}
