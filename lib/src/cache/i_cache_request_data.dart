import 'dart:async';

import 'package:dio/dio.dart';

import 'package:popnetwork/src/cache/request_cache_key.dart';

/// [ICacheRequestData] is a contract with the basics methods for managing the
/// cache storage for the requests data.
abstract class ICacheRequestData {
  Future<void> completeRequest({
    required RequestCacheKey key,
    Response<dynamic>? response,
  });

  Future<Response<dynamic>?>? getRequestResponse({
    required RequestCacheKey key,
  });

  Future<void> addRequest({required RequestCacheKey key});

  Future<void> removeRequest({required RequestCacheKey key});

  Future<RequestCacheKey?> getRequestKey({
    required RequestCacheKey key,
  });

  Future<void> clearRequestsData();
}
