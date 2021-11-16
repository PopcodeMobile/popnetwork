class TimeoutConfig {
  TimeoutConfig({
    required int connectionTimeout,
    required int receiveTimeout,
  })  : _connectionTimeout = connectionTimeout,
        _receiveTimeout = receiveTimeout;

  final int _connectionTimeout;
  final int _receiveTimeout;

  final int _milliseconds = 1000;

  int get connectionTimeout => _connectionTimeout * _milliseconds;

  int get receiveTimeout => _receiveTimeout * _milliseconds;
}
