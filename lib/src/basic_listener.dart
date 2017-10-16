part of socketcluster_client;

abstract class BasicListener {
  void onConnected(Socket socket);

  void onDisconnected(Socket socket);

  void onConnectError(Socket socket, dynamic e);

  void onAuthentication(Socket socket, bool status);

  void onSetAuthToken(String token, Socket socket);
}