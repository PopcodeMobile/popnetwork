import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pop_network/src/http/obsevers/network_error_observable/network_error_observable.dart';
import 'package:pop_network/src/http/obsevers/network_error_observable/network_error_type.dart';
import 'package:pop_network/src/internet_connection_checker/internet_connection_checker.dart';

class CheckConnectionInterceptor extends Interceptor {
  CheckConnectionInterceptor({
    required this.dio,
    required this.connectionChecker,
  });

  final Dio dio;
  final InternetConnectionChecker connectionChecker;

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.error != null) {
      if (err.error is SocketException) {
        if (!await connectionChecker.isConnected()) {
          NetworkErrorObserver.instance
              .createNotification(errorType: NetworkErrorType.noConnection);
        }
      }
      if (err.response?.statusCode == 404) {
        NetworkErrorObserver.instance
            .createNotification(errorType: NetworkErrorType.notfound);
      }
    }

    handler.next(err);
  }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isConnected = await connectionChecker.isConnected();
    if (!isConnected) {
      NetworkErrorObserver.instance
          .createNotification(errorType: NetworkErrorType.noConnection);
      await connectionChecker.handleRetryWhenInternetBack();
    }
    handler.next(options);
  }
}
