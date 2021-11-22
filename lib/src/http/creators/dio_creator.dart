import 'package:dio/dio.dart';
import 'package:network/src/http/creators/ssl_pinning.dart';
import 'package:network/src/http/http_config.dart';
import 'package:network/src/http/intercerptors/check_connection_interceptor.dart';
import 'package:network/src/internet_connection_checker/internet_connection_checker.dart';

class DioCreator {
  static late DioCreator _instance;
  late Map<String, dynamic>? headers;
  String baseUrl = '';
  DioCreator._();
  SSLPinning? _pinning;

  factory DioCreator() {
    return _instance;
  }

  static void init({
    String? baseUrl,
    Map<String, dynamic>? headers,
    SSLPinning? pinning,
  }) {
    _instance = DioCreator._()
      ..headers = headers
      ..baseUrl = baseUrl ?? ''
      .._pinning = pinning;
  }

  static Future<Dio> create({
    int? timeout,
  }) async {
    final Dio dioCreator = Dio()
      ..options.baseUrl = _instance.baseUrl
      ..options.connectTimeout =
          timeout ?? HttpConfig.timeoutConfig.connectionTimeout
      ..options.receiveTimeout = HttpConfig.timeoutConfig.receiveTimeout
      ..options.headers = _instance.headers;

    dioCreator.interceptors.add(CheckConnectionInterceptor(
      connectionChecker: InternetConnectionCheckerImpl(),
      dio: dioCreator,
    ));

    if (_instance._pinning != null) {
      await _instance._pinning!.pinningCertificate(
        httpClientAdapter: dioCreator.httpClientAdapter,
      );
    }

    return dioCreator;
  }
}
