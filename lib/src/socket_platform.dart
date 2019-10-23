export 'socket_platform_interface.dart';

import 'socket_platform_interface.dart'
  if (dart.library.js) './socket_platform_http.dart'
  if (dart.library.io) './socket_platform_io.dart';

import 'socket_platform_interface.dart' show SocketPlatform;

SocketPlatform _globalSocketPlatform = RuntimeSocketPlatform ;

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

/// Reset the globally configured socket platform.
void resetGlobalSocketPlatform() {
  _globalSocketPlatform = null;
}
