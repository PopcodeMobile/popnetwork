///Responsible for configuring the default network layer timeout settings.
class TimeoutConfig {
  TimeoutConfig({
    required int connectionTimeout,
    required int receiveTimeout,
  })  : _connectionTimeout = connectionTimeout,
        _receiveTimeout = receiveTimeout;

  final int _connectionTimeout;
  final int _receiveTimeout;

  final int _milliseconds = 1000;

  ///Set the timeout of a request in milliseconds
  int get connectionTimeout => _connectionTimeout * _milliseconds;

  ///Set the timeout in milliseconds
  int get receiveTimeout => _receiveTimeout * _milliseconds;
}
