import 'dart:async';

import 'package:dio/dio.dart';

import 'package:pop_network/src/cache/i_cache_request_data.dart';
import 'package:pop_network/src/cache/request_cache_key.dart';

/// [MemoryCacheRequestData] is a class that implements [ICacheRequestData] and
/// manages the cache storage for the requests data in memory using a Map.
class MemoryCacheRequestData implements ICacheRequestData {
  final _requestsData = <RequestCacheKey, Completer<Response<dynamic>?>>{};

  @override
  Future<void> completeRequest({
    required RequestCacheKey key,
    Response<dynamic>? response,
  }) async {
    _requestsData[key]?.complete(response);
  }

  @override
  Future<Response<dynamic>?>? getRequestResponse({
    required RequestCacheKey key,
  }) =>
      _requestsData[key]?.future;

  @override
  Future<void> addRequest({required RequestCacheKey key}) async {
    _requestsData[key] = Completer<Response<dynamic>?>();
  }

  @override
  Future<void> removeRequest({required RequestCacheKey key}) async {
    _requestsData.remove(key);
  }

  @override
  Future<RequestCacheKey?> getRequestKey({
    required RequestCacheKey key,
  }) async {
    final result = _requestsData.keys.where((_key) => _key == key);
    return result.isEmpty ? null : result.first;
  }

  @override
  Future<void> clearRequestsData() async => _requestsData.clear();
}
