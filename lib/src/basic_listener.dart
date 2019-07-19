import 'socket.dart';
///Interface for listening to a socket through callbacks
///
abstract class BasicListener {
  /// Function called when [socket] is connected
  ///
  void onConnected(Socket socket);

  /// Function called when [socket] disconnects
  ///
  void onDisconnected(Socket socket);

  /// Function called if a connection attempt causes an error
  ///
  void onConnectError(Socket socket, dynamic e);

  void onAuthentication(Socket socket, bool status);

  void onSetAuthToken(String token, Socket socket);
}
