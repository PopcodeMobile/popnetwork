import 'dart:io';

import 'package:dio/dio.dart';
import 'package:network/src/endpoint/endpoint.dart';
import 'package:network/src/http/creators/ssl_pinning.dart';
import 'package:network/src/http/http_config.dart';
import 'package:network/src/http/intercerptors/check_connection_interceptor.dart';
import 'package:network/src/http/provider/dio/helpers/request_helper.dart';
import 'package:network/src/http/provider/dio/helpers/response_type_dio_helper.dart';
import 'package:network/src/internet_connection_checker/internet_connection_checker.dart';
import 'package:network/src/response/network_response.dart';
import 'package:network/src/util/query_formatter.dart';

part '../provider/dio/helpers/delete_helper.dart';
part '../provider/dio/helpers/get_helper.dart';
part '../provider/dio/helpers/patch_helper.dart';
part '../provider/dio/helpers/post_helper.dart';
part '../provider/dio/helpers/put_helper.dart';

class DioCreator {
  static late DioCreator _instance;

  /// Variables that can be initialized when starting the Application.

  List<Interceptor> interceptors = [];
  Map<String, dynamic>? headers;
  String baseUrl = '';
  SSLPinning? _pinning;
  Map<String, dynamic>? queryParameters;

  DioCreator._();

  factory DioCreator() {
    return _instance;
  }

  /// init()
  ///
  /// Function responsible for starting DioCreator

  static void init({
    String? baseUrl,
    Map<String, dynamic>? headers,
    SSLPinning? pinning,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
  }) {
    _instance = DioCreator._()
      ..headers = headers
      ..baseUrl = baseUrl ?? ''
      .._pinning = pinning
      ..queryParameters = queryParameters;

    if (interceptors != null) {
      _instance.interceptors.addAll(interceptors);
    }
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

    _instance.interceptors.forEach(
      (interceptor) {
        dioCreator.interceptors.add(interceptor);
      },
    );

    return dioCreator;
  }
}
