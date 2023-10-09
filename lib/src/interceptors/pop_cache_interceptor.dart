import 'dart:async';

import 'package:dio/dio.dart';

import 'package:popnetwork/src/cache/i_cache_request_data.dart';
import 'package:popnetwork/src/cache/request_cache_key.dart';

/// [PopCacheInterceptor] is an interceptor that adds support for caching
/// requests with a specified [cacheExpiresIn] duration.
/// The cache storage could be managed by any class that implements the
/// [ICacheRequestData] interface.
class PopCacheInterceptor extends Interceptor {
  PopCacheInterceptor({
    required ICacheRequestData cacheRequestData,
  }) : _cacheReqData = cacheRequestData;

  final ICacheRequestData _cacheReqData;

  Duration? _getCacheExpiresIn(RequestOptions option) =>
      option.extra['cacheExpiresIn'];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final cacheExpiresIn = _getCacheExpiresIn(options);
    if (cacheExpiresIn == null) {
      return handler.next(options);
    }

    final reqKey = RequestCacheKey.fromRequestOptions(options);
    final oldKey = _cacheReqData.getRequestKey(key: reqKey);
    if (oldKey != null && !oldKey.isCacheExpired) {
      final request = _cacheReqData.getRequestResponse(key: reqKey);
      if (request != null) {
        final requestResult = await request;
        if (requestResult != null) {
          handler.resolve(requestResult);
          return;
        }
      }
    }
    _cacheReqData.removeRequest(key: reqKey);
    _cacheReqData.addRequest(key: reqKey);

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (_getCacheExpiresIn(response.requestOptions) != null) {
      _cacheReqData.completeRequest(
        key: RequestCacheKey.fromRequestOptions(response.requestOptions),
        response: response,
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_getCacheExpiresIn(err.requestOptions) != null) {
      _cacheReqData.completeRequest(
        key: RequestCacheKey.fromRequestOptions(err.requestOptions),
      );
    }
    handler.next(err);
  }
}
