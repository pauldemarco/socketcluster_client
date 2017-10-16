# SocketCluster Dart Client

SocketCluster Client is the client-side component of SocketCluster.

## Example Usage
```dart
  var socket = await Socket.connect('ws://localhost:8000/socketcluster/',
      listener: new MyListener());
  socket.on('rand', (name, data, ack) {
    print('got message $data from event $name');
    ack(name, 'No error', 'Hi there buddy');
  });
```

## Note
This is a straight and dirty port from the C# client.

Large changes will be made to clean this up and make it more 'Dartified'

For instance, BasicListener will be removed in favor of Stream<Updates>

