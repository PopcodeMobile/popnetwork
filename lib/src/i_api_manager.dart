import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:pop_network/src/mock/mock_reply_params.dart';

/// [IApiManager] is an abstract class that extends [DioForNative] and
/// adds support for mocking requests.
abstract class IApiManager extends DioForNative {
  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  });

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  });

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  });

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  });

  @override
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Duration? cacheExpiresIn,
    MockReplyParams? mockReplyParams,
  });
}
