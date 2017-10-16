part of socketcluster_client;

class Channel
{
  final String name;
  final Socket socket;

  Channel(this.socket, this.name);

  Channel subscribe([AckCall ack])
  {
    socket.subscribe(name, ack);
    return this;
  }

  void onMessage(Listener listener)
  {
    socket.onSubscribe(name, listener);
  }

  void publish(dynamic data, [AckCall ack])
  {
    socket.publish(name, data, ack);
  }

  void unsubscribe([AckCall ack])
  {
    socket.unsubscribe(name, ack);
    socket.channels.remove(this);
  }
}