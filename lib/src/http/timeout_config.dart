///Responsible for configuring the default network layer timeout settings.
class TimeoutConfig {
  TimeoutConfig({
     int? connectionTimeout,
     int? receiveTimeout,
  })  : _connectionTimeout = connectionTimeout ?? 30,
        _receiveTimeout = receiveTimeout ?? 30;

  final int _connectionTimeout;
  final int _receiveTimeout;

  ///Set the timeout of a request in seconds
  Duration get connectionTimeout => Duration(seconds: _connectionTimeout);

  ///Set the timeout in seconds
  Duration get receiveTimeout => Duration(seconds: _receiveTimeout);
}
