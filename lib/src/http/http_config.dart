import 'package:pop_network/src/http/timeout_config.dart';

///Responsible for storing the default network layer timeout settings.
abstract class HttpConfig {
  /// conection and response timeout in secunds
  static final TimeoutConfig timeoutConfig =
      TimeoutConfig(connectionTimeout: 30, receiveTimeout: 30);
}
