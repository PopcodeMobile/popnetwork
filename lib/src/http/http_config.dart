import 'package:popwork/src/http/timeout_config.dart';

class HttpConfig {
  /// conection and response timeout in secunds
  static final TimeoutConfig timeoutConfig =
      TimeoutConfig(connectionTimeout: 30, receiveTimeout: 30);
}
