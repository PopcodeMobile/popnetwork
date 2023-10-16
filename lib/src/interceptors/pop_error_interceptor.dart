import 'package:dio/dio.dart';

/// [PopErrorInterceptor] is used to resolve with a [Response] even when an
/// [DioException] occurs. The response contains the same data from
/// [DioException.response] or it's own properties when the [Response] is null.
///
/// It's better to add [PopErrorInterceptor] to the tail of the interceptor queue,
/// otherwise it could interfere in the behavior of the others interceptors.
/// This is because the execution of interceptors is in the order of addition.
class PopErrorInterceptor extends Interceptor {
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    handler.resolve(
      Response(
        requestOptions: err.requestOptions,
        statusMessage: err.response?.statusMessage ?? err.message,
        statusCode: err.response?.statusCode,
        data: err.response?.data ?? err.error,
        extra: err.response?.extra,
        headers: err.response?.headers,
        isRedirect: err.response?.isRedirect ?? false,
        redirects: err.response?.redirects ?? const [],
      ),
    );
  }
}
