class ReconnectStrategy
{
  /**
   *The number of milliseconds to delay before attempting to reconnect.
   * Default: 2000
   */
  final int reconnectInterval;

  /**
   * The maximum number of milliseconds to delay a reconnection attempt.
   * Default: 30000
   */
  final int maxReconnectInterval;

  /**
   * The maximum number of reconnection attempts that will be made before giving up. If null, reconnection attempts will be continue to be made forever.
   * Default: null
   */
  final int maxAttempts;

  var attmptsMade = 0;

  ReconnectStrategy({this.reconnectInterval = 3000, this.maxReconnectInterval = 30000, this.maxAttempts = null});

  void reset()
  {
    attmptsMade = 0;
  }

  void processValues()
  {
    attmptsMade++;
  }

  int getReconnectInterval(){
    return reconnectInterval;
  }

  bool areAttemptsComplete() => attmptsMade >= maxAttempts;
}
