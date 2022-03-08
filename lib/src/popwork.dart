import 'dart:io';

import 'package:dio/dio.dart';
import 'package:popwork/src/endpoint/endpoint.dart';
import 'package:popwork/src/http/http_config.dart';
import 'package:popwork/src/http/provider/dio/helpers/request_helper.dart';
import 'package:popwork/src/http/provider/dio/helpers/response_type_dio_helper.dart';
import 'package:popwork/src/http/ssl_pinning/ssl_pinning.dart';
import 'package:popwork/src/response/network_response.dart';
import 'package:popwork/src/util/query_formatter.dart';

part 'http/provider/dio/helpers/delete_helper.dart';
part 'http/provider/dio/helpers/get_helper.dart';
part 'http/provider/dio/helpers/patch_helper.dart';
part 'http/provider/dio/helpers/post_helper.dart';
part 'http/provider/dio/helpers/put_helper.dart';

class Popwork {
  Popwork._();
  static late Popwork _instance;
  factory Popwork() => _instance;

  /// Variables that can be initialized when starting the Application.

  List<Interceptor> interceptors = [];
  Map<String, dynamic>? headers;
  String baseUrl = '';
  String pathMock = '';
  SSLPinning? _pinning;
  Map<String, dynamic>? queryParameters;
  Dio? dio;

  static String get pathMocks => _instance.pathMock;
  static Dio get dioCreator => _instance.dio ?? Dio();

  ///
  /// Function responsible for starting Popwork

  static Future<void> config({
    String? baseUrl,
    String? pathMock,
    Map<String, dynamic>? headers,
    SSLPinning? pinning,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
  }) async {
    _instance = Popwork._()
      ..headers = headers
      ..pathMock = pathMock ?? 'api/mock/'
      ..baseUrl = baseUrl ?? ''
      .._pinning = pinning
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
  }
}
