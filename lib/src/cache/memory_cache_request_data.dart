import 'dart:async';

import 'package:dio/dio.dart';

import 'package:popnetwork/src/cache/i_cache_request_data.dart';
import 'package:popnetwork/src/cache/request_cache_key.dart';

class MemoryCacheRequestData implements ICacheRequestData {
  final _requestsData = <RequestCacheKey, Completer<Response<dynamic>?>>{};

  @override
  void completeRequest({
    required RequestCacheKey key,
    Response<dynamic>? response,
  }) {
    _requestsData[key]?.complete(response);
  }

  @override
  Future<Response<dynamic>?>? getRequestResponse({
    required RequestCacheKey key,
  }) async =>
      await _requestsData[key]?.future;

  @override
  void addRequest({required RequestCacheKey key}) {
    _requestsData[key] = Completer<Response<dynamic>?>();
  }

  @override
  void removeRequest({required RequestCacheKey key}) {
    _requestsData.remove(key);
  }

  @override
  RequestCacheKey? getRequestKey({
    required RequestCacheKey key,
  }) {
    final result = _requestsData.keys.where((_key) => _key == key);
    return result.isEmpty ? null : result.first;
  }

  @override
  void clearRequestsData() => _requestsData.clear();
}
