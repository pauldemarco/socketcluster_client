import 'package:socketcluster_client/socketcluster_client.dart';
import 'dart:async';

class MyListener extends BasicListener {
  @override
  void onAuthentication(Socket socket, bool status) {
    print('onAuthentication: socket $socket status $status');
  }

  @override
  void onConnectError(Socket socket, e) {
    print('onConnectError: socket $socket e $e');
  }

  @override
  void onConnected(Socket socket) {
    print('onConnected: socket $socket');
    new Timer.periodic(const Duration(seconds: 2), (_) {
      print('Attempting to send');
      socket.emit('sampleClientEvent',
          {'message': 'This is an object with a message property'});
    });
  }

  @override
  void onDisconnected(Socket socket) {
    print('onDisconnected: socket $socket');
  }

  @override
  void onSetAuthToken(String token, Socket socket) {
    print('onSetAuthToken: socket $socket token $token');
    socket.authToken = token;
  }
}

main() async {
  var socket = await Socket.connect('ws://localhost:8000/socketcluster/',
      listener: new MyListener());
  socket.on('rand', (name, data, ack) {
    print('got message $data from event $name');
    ack(name, 'No error', 'Hi there buddy');
  });
}
