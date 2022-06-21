import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/http/http_config.dart';
import 'package:pop_network/src/http/provider/dio/helpers/request_helper.dart';
import 'package:pop_network/src/http/provider/dio/helpers/response_type_dio_helper.dart';
import 'package:pop_network/src/http/ssl_pinning/ssl_pinning.dart';
import 'package:pop_network/src/response/network_response.dart';
import 'package:pop_network/src/util/query_formatter.dart';

part 'http/provider/dio/helpers/delete_helper.dart';
part 'http/provider/dio/helpers/get_helper.dart';
part 'http/provider/dio/helpers/patch_helper.dart';
part 'http/provider/dio/helpers/post_helper.dart';
part 'http/provider/dio/helpers/put_helper.dart';

class PopNetwork {
  PopNetwork._();
  static late PopNetwork _instance;
  factory PopNetwork() => _instance;

  /// Variables that can be initialized when starting the Application.

  List<Interceptor> interceptors = [];
  Map<String, dynamic>? headers;
  String baseUrl = '';
  String? pathMock;
  SSLPinning? _pinning;
  Map<String, dynamic>? queryParameters;
  Dio? dio;
  bool mockedEnvironment = false;

  static String get pathMocks => _instance.pathMock ?? 'assets/api/mock';
  static Dio get dioCreator => _instance.dio ?? Dio();
  static bool get isMock => _instance.mockedEnvironment;

  static String errorMessage = '';

  ///
  /// Function responsible for starting pop_network
  ///
  ///

  static Future<void> config({
    String? baseUrl,
    String? pathMock,
    String? errorMessage,
    Map<String, dynamic>? headers,
    SSLPinning? pinning,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
    bool mockedEnvironment = false,
  }) async {
    _instance = PopNetwork._()
      ..headers = headers
      ..pathMock = pathMock
      ..baseUrl = baseUrl ?? ''
      .._pinning = pinning
      ..mockedEnvironment = mockedEnvironment
      ..queryParameters = queryParameters;

    final dioCreate = Dio()
      ..options.baseUrl = _instance.baseUrl
      ..options.receiveTimeout = HttpConfig.timeoutConfig.receiveTimeout
      ..options.headers = _instance.headers;

    if (interceptors != null) {
      interceptors.forEach(
        (interceptor) {
          dioCreate.interceptors.add(interceptor);
        },
      );
    }
    await _instance._pinning?.pinningCertificate(
      httpClientAdapter: dioCreate.httpClientAdapter,
    );
    _instance.dio = dioCreate;
    errorMessage =
        errorMessage ?? 'Sorry, there was a problem. Please try again later.';
  }
}
