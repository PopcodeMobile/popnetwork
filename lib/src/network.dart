import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pop_network/src/endpoint/endpoint.dart';
import 'package:pop_network/src/http/http_config.dart';
import 'package:pop_network/src/http/provider/dio/helpers/request_helper.dart';
import 'package:pop_network/src/http/provider/dio/helpers/response_type_dio_helper.dart';
import 'package:pop_network/src/http/ssl_pinning/ssl_pinning.dart';
import 'package:pop_network/src/response/network_response.dart';
import 'package:pop_network/src/response/states/apiError/mapped_api_error.dart';
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
  String pathMock = 'assets/api/mock';
  SSLPinning? _pinning;
  Map<String, dynamic>? queryParameters;
  MappedApiError? mappedApiError;
  Dio? dio;
  bool mockedEnvironment = false;

  static String get pathMocks => _instance.pathMock;
  static Dio get dioCreator => _instance.dio ?? Dio();
  static MappedApiError get mapApiError =>
      _instance.mappedApiError ?? MappedApiErrorDefault();
  static bool get isMock => _instance.mockedEnvironment;

  ///
  /// Function responsible for starting pop_network
  ///
  ///

  static Future<void> config({
    String? baseUrl,
    String? pathMock,
    Map<String, dynamic>? headers,
    SSLPinning? pinning,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
    MappedApiError? mappedApiError,
    bool mockedEnvironment = false,
  }) async {
    _instance = PopNetwork._()
      ..headers = headers
      ..pathMock = pathMock ?? 'assets/api/mock/'
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
    _instance.mappedApiError = mappedApiError;
    _instance.dio = dioCreate;
  }
}
