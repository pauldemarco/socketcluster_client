import 'dart:async';
import './channel.dart';
import './reconnect_strategy.dart';
import './basic_listener.dart';
import './emitter.dart';

abstract class SocketInterface extends Emitter {
  dynamic _socket;
  String url;
  String id;
  ReconnectStrategy strategy;
  BasicListener listener;
  int _counter = 0;
  String authToken;
  List<Channel> channels;
  Map<int, List<dynamic>> _acks;

  int get state => _socket.readyState ?? CLOSED;

  static const int CONNECTING = 0;
  static const int OPEN = 1;
  static const int CLOSING = 2;
  static const int CLOSED = 3;

  static Future connect(String url, {String authToken, ReconnectStrategy strategy, BasicListener listener}){
    return new Future(()=>null);
  }

  void setProxy(String host, int port);

  void setSSLCertVerification(bool value);

  void onSocketOpened([event]);

  void onSocketDone([event]);

  Channel createChannel(String name);

  void handleMessage([message]);

  AckCall ack(int cid);

  SocketInterface emit(String event, Object data, [AckCall ack]);

  SocketInterface subscribe(String channel, [AckCall ack]);

  SocketInterface unsubscribe(String channel, [AckCall ack]);

  SocketInterface publish(String channel, Object data, [AckCall ack]);

  List<dynamic> getAckObject(String event, AckCall ack);

  void subscribeChannels();
}
