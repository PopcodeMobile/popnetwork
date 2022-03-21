import 'package:dio/dio.dart';
import 'package:pop_network/src/http/intercerptors/retry_interceptor/i_routes_with_retry.dart';
import 'package:pop_network/src/http/intercerptors/utils/interceptor_utils.dart';
import 'package:pop_network/src/http/obsevers/network_error_observable/network_error_observable.dart';
import 'package:pop_network/src/http/obsevers/network_error_observable/network_error_type.dart';

class RetryRequestInterceptor extends Interceptor {
  RetryRequestInterceptor({
    required this.dio,
    required this.routesWithRetry,
  });
  final Dio dio;
  final IRoutesWithRetry routesWithRetry;

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final politicaRetry = routesWithRetry.getPolitica(err.requestOptions.path);
    if (politicaRetry == null) {
      handler.next(err);
      return err;
    }

    if (politicaRetry.attempts == 0) {
      _notifyMaxRetries(err);
      handler.next(err);
      return err;
    }

    try {
      if (politicaRetry.attempts > 0 && _shouldRetry(err)) {
        politicaRetry.decrementAttempts();
        return scheduleRequestRetry(err.requestOptions);
      }
    } catch (e) {
      return e;
    }

    return err;
  }

  bool _shouldRetry(DioError err) {
    if (_mapStatusCodeToNetworkErrorType
            .containsKey(err.response?.statusCode) ||
        _mapDioErrorTypeToNetworkError.containsKey(err.type)) {
      return true;
    }
    return false;
  }

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    return dio.request<dynamic>(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: InterceptorUtils.convertToOptions(requestOptions),
    );
  }

  void _notifyMaxRetries(DioError error) {
    if (_mapStatusCodeToNetworkErrorType
        .containsKey(error.response?.statusCode)) {
      NetworkErrorObserver.instance.createNotification(
          errorType:
              _mapStatusCodeToNetworkErrorType[error.response?.statusCode]);
    } else if (_mapDioErrorTypeToNetworkError.containsKey(error.type)) {
      NetworkErrorObserver.instance.createNotification(
          errorType: _mapDioErrorTypeToNetworkError[error.type]);
    }
  }

  static const Map<int, NetworkErrorType> _mapStatusCodeToNetworkErrorType = {
    504: NetworkErrorType.connectionTimeout,
    502: NetworkErrorType.connectionTimeout,
    500: NetworkErrorType.connectionTimeout
  };
  static const Map<DioErrorType, NetworkErrorType>
      _mapDioErrorTypeToNetworkError = {
    DioErrorType.connectTimeout: NetworkErrorType.connectionTimeout,
    DioErrorType.receiveTimeout: NetworkErrorType.connectionTimeout
  };
}
