import 'package:dio/dio.dart';
import 'package:network/src/http/http_config.dart';
import 'package:network/src/http/intercerptors/check_connection_interceptor.dart';
import 'package:network/src/internet_connection_checker/internet_connection_checker.dart';

class DioCreator {
  static late DioCreator _instance;
  late Map<String, dynamic>? headers;
  late String baseUrl;
  DioCreator._();

  factory DioCreator() {
    return _instance;
  }

  static void init({
    Map<String, dynamic>? headers,
    required String baseUrl,
  }) {
    _instance = DioCreator._()
      ..headers = headers
      ..baseUrl = baseUrl;
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

    return dioCreator;
  }
}
