import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pop_network/src/connection_checker/conection_checker.dart';
import 'package:pop_network/src/http/obsevers/network_error_observable/network_error_observable.dart';
import 'package:pop_network/src/http/obsevers/network_error_observable/network_error_type.dart';

class CheckConnectionInterceptor extends Interceptor {
  CheckConnectionInterceptor({
    required this.dio,
  });

  final Dio dio;

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.error != null) {
      if (err.error is SocketException) {
        if (!await ConnectionChecker.isConnectedToInternet()) {
          NetworkErrorObserver.instance
              .createNotification(errorType: NetworkErrorType.noConnection);
        }
      }
      if (err.response?.statusCode == 404) {
        NetworkErrorObserver.instance
            .createNotification(errorType: NetworkErrorType.notFound);
      }
    }

    handler.next(err);
  }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isConnected = await ConnectionChecker.isConnectedToInternet();
    if (!isConnected) {
      NetworkErrorObserver.instance
          .createNotification(errorType: NetworkErrorType.noConnection);
    }
    handler.next(options);
  }
}
