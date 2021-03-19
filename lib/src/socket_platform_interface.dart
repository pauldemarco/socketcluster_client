class SocketPlatform {
  const SocketPlatform();
  /// Constructs a new [WebSocket] instance.
  dynamic webSocket([url]) {}
}

// Declare all the Base Types of SocketPlatforms here so that they can be used
// for type checking externally without breaking platform specific imports
// such as `dart:io` or `dart:html` when not on that platform.

/// Stub for dynamic Import
class HttpSocketPlatform extends SocketPlatform {
  const HttpSocketPlatform();
}

class IoSocketPlatform extends SocketPlatform {
  const IoSocketPlatform();
}

const SocketPlatform? RuntimeSocketPlatform = null;
