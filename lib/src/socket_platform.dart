import 'socket_platform_interface.dart';

// Use conditional imports in order to automatically setup the platform without any user side setup.
export 'socket_platform_interface.dart'
  // `dart.library.js` is compatible with node and browser via dart2js -- `dart.library.html` will only work for the browser
  // or at lest it seemed it should be, when I tried `dart.library.js` in chrome, it failed to evaluate to true
  if (dart.library.io) './socket_platform_io.dart'
  if (dart.library.js) './socket_platform_http.dart';

SocketPlatform _globalSocketPlatform;

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
